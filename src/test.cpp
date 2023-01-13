#include "verilated.h"
#define CONCAT(A, B) A##B
#define CAT(A, B) CONCAT(A, B)
#define SUFF(x) CONCAT(x,_)
#define PREFIX(x) CAT(SUFF(VPREFIX),x)

struct TestCase {
	const char* name;
  uint8_t reset;
	uint8_t cmd;
 	uint16_t load_addr;
 	uint16_t expected_addr;
};

TestCase test_cases[] {
	{ "reset", 1, PREFIX(microaddr)::cmd::NONE, 0, 0 },
	{ "inc", 0, PREFIX(microaddr)::cmd::INC, 0, 1 },
  { "none", 0, PREFIX(microaddr)::cmd::NONE, 0, 1 },
  { "reset2", 1, PREFIX(microaddr)::cmd::NONE, 0, 0 },
	{ "load", 0, PREFIX(microaddr)::cmd::LOAD, 0xFA, 0xFA},
	{ "inc", 0, PREFIX(microaddr)::cmd::INC, 0, 0xFB},
  { "reset3", 1, PREFIX(microaddr)::cmd::NONE, 0, 0 },
};

int main(int argc, char **argv, char **env) {
  Verilated::commandArgs(argc, argv);
  VPREFIX* counter = new VPREFIX;
  
  counter->clk = 0;
  counter->reset = 0;
  counter->cmd = PREFIX(microaddr)::cmd::NONE;
  counter->load_addr = 0;
  counter->eval();

  // while (!Verilated::gotFinish()) { 
  int num_test_cases = sizeof(test_cases)/sizeof(TestCase);

  for(int k = 0; k < num_test_cases; k++) {
    TestCase *test_case = &test_cases[k];

  	counter->cmd = test_case->cmd;
    counter->reset = test_case->reset;
  	counter->load_addr = test_case->load_addr;  	
    counter->eval();

    counter->clk = 1;
    counter->eval();
    counter->clk = 0;
    counter->eval();

    if (counter->addr == test_case->expected_addr) {
    	printf("%s: passed\n", test_case->name);
    } else {
    	printf("%s: fail (expected %04X but was %04X)\n",
    		test_case->name, test_case->expected_addr,
    		counter->addr);
    }
  }
  counter->final();
  delete counter;
  exit(0);
}