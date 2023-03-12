#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <cstring>
#include <iomanip>
#include <atomic>
#include <unistd.h>
#include <termios.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <sys/signal.h>
#define ROUND_UP(R, M) (M + (M%R)?(R - (M%R)):0)
static int fd;

int setup_tty(int fd, uint32_t baudrate);
uint8_t readsum = 0;
std::atomic<uint8_t> read_sum(0);
std::atomic<bool> ready(false);
void io_handler(int sig) {
	int err = 0;
	uint8_t c = 0;
	// Read data back
	err = read(fd, &c, 1);
	if(err < 0) {
		//std::cerr << "\nRead error"  << std::endl;
	}
	read_sum.store(c);
	ready.store(true);
}

int main(int argc, char *argv[]) {
	signal(SIGIO,io_handler);
	if(argc != 3) {
		std::cerr << "Usage: " << argv[0] << " <input file> <output file>" << std::endl;
		return 1;
	}
	// Open input file
	std::ifstream input(argv[1], std::ios::binary);
	if(!input) {
		std::cerr << "Error: Could not open input file " << argv[1] << std::endl;
		return 1;
	}
	// Open output TTY
	fd = open(argv[2], O_RDWR);
	if(fd == -1) {
		std::cerr << "Error: Could not open output TTY " << argv[2] << std::endl;
		return 1;
	}
	setup_tty(fd, B921600);
	int flags = fcntl(fd, F_GETFL, 0);
	if(flags == -1) {
		std::cerr << "Error: Could not get flags for TTY " << argv[2] << std::endl;
		return 1;
	}
	flags = fcntl(fd, F_SETFL, flags | O_NONBLOCK | O_FSYNC | O_ASYNC);
	if(flags == -1) {
		std::cerr << "Error: Could not set flags for TTY " << argv[2] << std::endl;
		return 1;
	}
	// Get input file size
	input.seekg(0, std::ios::end);
	size_t size = input.tellg();
	input.seekg(0, std::ios::beg);
	// Turn size int HEX string
	std::stringstream size_str;
	size_str << std::setfill('0') << std::setw(8) << std::hex << size << "\nn";
	std::cout << "Size: " << size_str.str().substr(0,8) << std::endl;
	// Wait for user to press enter
	std::cout << "Press enter to start transfer";
	while(getchar() != '\n');
	// Write size to output
	write(fd, size_str.str().c_str(), size_str.str().size());
	int err = 0;
	uint8_t c = 0;
	//clear input buffer
	while(!ready.load());
	usleep(1000);
	ready.store(false);
	//flush input buffer
	tcflush(fd, TCIFLUSH);
	std::cout << "Starting transfer..." << std::endl;
	const size_t buffer_size = 4;
	time_t start = time(NULL);
	uint32_t status = 0;
	uint32_t last_status = 0;
	uint32_t sum = 0;
	uint32_t err_count = 0;
	// Write input to output
	while(1) {
		if(status >= size){
			break;
		}
		usleep(50);
		uint32_t buffer;
		input.seekg(status, std::ios::beg);
		input.read((char*)&buffer, 4);
		sum += buffer;
		err = write(fd, &buffer, input.gcount());
		if(err < 0) {
			std::cerr << "\nWrite error" << std::endl;
			return 1;
		}
		tcflush(fd, TCIFLUSH);
		status += input.gcount();
		if((status-last_status) == 256) {
			bool invalidated = false;
			printf("\rProgress: %0.3lf%%", (double)(status * 100) / ((double)size));
			uint32_t now = time(NULL);
			// print MB/s
			printf(" (%0.2lf KiB/s)", status / (1024.0) / (now - start));
			printf(" (%.1fKiB) ", status/1024.0);
			printf(" errors: %d ", err_count);
			fflush(stdout);
			while(!ready.load()){
				if(time(NULL) - now > 5) {
					std::cerr << "\nTimeout" << std::endl;
					tcflush(fd, TCIFLUSH);
					char c = 0;
					err = write(fd, &c, 1);
					if(err < 0) {
						std::cerr << "\nWrite error in resend" << std::endl;
						return 1;
					}
					tcflush(fd, TCIFLUSH);
					usleep(1000);
					invalidated = true;
				}
			}
			ready.store(false);
			uint8_t s = (sum&0xff);
			if(s != read_sum.load() || invalidated) {
				err_count++;
				// invalid checksum even if valid
				s++;
				std::cerr << (int)s << " != " << (int)read_sum.load() << "  ";
				status = last_status;
			} else {
				//std::cerr << (int)s << " == " << (int)read_sum.load() << std::endl;
				last_status = status;
			}
			err = write(fd, &s, 1);
			if(err < 0) {
				std::cerr << "\nWrite error in checksum" << std::endl;
				return 1;
			}
			tcflush(fd, TCIFLUSH);
			sum = 0;
		}
	}
	std::cout << "\rProgress: 100%       \nDone... Open screen and press enter."<< std::endl;
	// Close files
	close(fd);
	input.close();
	return 0;
}
int setup_tty(int fd, uint32_t baudrate) {
	// Set output TTY to raw mode
	struct termios tty;
	memset(&tty, 0, sizeof(tty));
	if ( tcgetattr ( fd, &tty ) != 0 ) {
		std::cerr << "Error " << errno << " from tcgetattr: " << strerror(errno) << std::endl;
		return 1;
	}
	cfsetospeed(&tty, baudrate);
	cfsetispeed(&tty, baudrate);
	cfmakeraw(&tty);
	/* Setting other Port Stuff */
	//tty.c_cflag     &=  ~PARENB;        // Make 8n1
	//tty.c_cflag     &=  ~CSTOPB;
	////tty.c_cflag     &=  ~CSIZE;
	tty.c_cflag     |=  CS8;
	//tty.c_cflag     &=  ~CRTSCTS;       // no flow control
	//tty.c_lflag     =   0;          // no signaling chars, no echo, no canonical processing
	//tty.c_oflag     =   0;                  // no remapping, no delays
	tty.c_cc[VMIN]      =   0;                  // read doesn't block
	tty.c_cc[VTIME]     =   1;                  // 0.5 seconds read timeout
//	tty.c_cflag     |=  CREAD | CLOCAL;     // turn on READ & ignore ctrl lines
	//tty.c_iflag     = 0;// turn off s/w flow ctrl
	//tty.c_lflag     = 0; // make raw
	//tty.c_oflag     = 0;              // make raw
	/* Flush Port, then applies attributes */
	tcflush( fd, TCIFLUSH );
	if ( tcsetattr ( fd, TCSANOW, &tty ) != 0) {
		std::cerr << "Error " << errno << " from tcsetattr" << std::endl;
		return 1;
	}
	return 0;
}