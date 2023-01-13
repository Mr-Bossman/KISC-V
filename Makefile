BUILD_DIR = build
PREFIX_NAME = RV32emu
CC = gcc
CXX = g++
CPPFLAGS = -DVPREFIX=${PREFIX_NAME}
LDFLAGS =
CPP_SOURCES = src/test.cpp
V_SOURCES = hdl/microaddr.v hdl/microaddr_counter.v
INCV_SOURCES = hdl/microaddr.v
INCLUDES = $(addprefix --include ${PREFIX_NAME}_,$(notdir $(INCV_SOURCES:.v=.h))) -include ${PREFIX_NAME}.h
CPPFLAGS += ${INCLUDES}


all : clean_exe ${PREFIX_NAME}

${PREFIX_NAME} :
	verilator -Wall --Mdir ${BUILD_DIR} -cc ${V_SOURCES} -prefix ${PREFIX_NAME} -CFLAGS "${CPPFLAGS}" ${CPP_SOURCES} --exe
	$(MAKE) -C ${BUILD_DIR} -f ${PREFIX_NAME}.mk ${PREFIX_NAME}
	cp ${BUILD_DIR}/${PREFIX_NAME} .

run: all
	./${PREFIX_NAME}

clean_exe:
	rm -rf ${PREFIX_NAME}

clean :
	rm -rf ${PREFIX_NAME} ${BUILD_DIR}
