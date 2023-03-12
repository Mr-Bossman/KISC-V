#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <cstring>
#include <iomanip>
#include <unistd.h>
#include <termios.h>
#include <fcntl.h>
#include <ext/stdio_filebuf.h>

int setup_tty(int fd, uint32_t baudrate);

int main(int argc, char *argv[]) {
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
	int fd = open(argv[2], O_RDWR);
	if(fd == -1) {
		std::cerr << "Error: Could not open output TTY " << argv[2] << std::endl;
		return 1;
	}
	setup_tty(fd, B115200);
	// Get input file size
	input.seekg(0, std::ios::end);
	size_t size = input.tellg();
	input.seekg(0, std::ios::beg);
	// Turn size int HEX string
	std::stringstream size_str;
	size_str << std::setfill('0') << std::setw(8) << std::hex << size;
	std::cout << "Size: " << size_str.str() << std::endl;
	// Wait for user to press enter
	std::cout << "Press enter to start transfer" << std::endl;
	while(getchar() != '\n');
	// Write size to output
	write(fd, size_str.str().c_str(), 8);
	// Write input to output
	while(1) {
		char buffer[4] = {0};
		input.read(buffer, 4);
		write(fd, buffer, input.gcount());
		usleep(100000);
		if(input.gcount() == 0)
			break;
	}
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
	/* Setting other Port Stuff */
	tty.c_cflag     &=  ~PARENB;        // Make 8n1
	tty.c_cflag     &=  ~CSTOPB;
	tty.c_cflag     &=  ~CSIZE;
	tty.c_cflag     |=  CS8;
	tty.c_cflag     &=  ~CRTSCTS;       // no flow control
	tty.c_lflag     =   0;          // no signaling chars, no echo, no canonical processing
	tty.c_oflag     =   0;                  // no remapping, no delays
	tty.c_cc[VMIN]      =   0;                  // read doesn't block
	tty.c_cc[VTIME]     =   5;                  // 0.5 seconds read timeout

	tty.c_cflag     |=  CREAD | CLOCAL;     // turn on READ & ignore ctrl lines
	tty.c_iflag     &=  ~(IXON | IXOFF | IXANY);// turn off s/w flow ctrl
	tty.c_lflag     &=  ~(ICANON | ECHO | ECHOE | ISIG); // make raw
	tty.c_oflag     &=  ~OPOST;              // make raw
	/* Flush Port, then applies attributes */
	tcflush( fd, TCIFLUSH );
	if ( tcsetattr ( fd, TCSANOW, &tty ) != 0) {
		std::cerr << "Error " << errno << " from tcsetattr" << std::endl;
		return 1;
	}
	return 0;
}