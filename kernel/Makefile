default: all

INCL ?= -I./include
XLEN ?= 32
RISCV_PREFIX ?= riscv$(XLEN)-unknown-elf-
RISCV_GCC ?= $(RISCV_PREFIX)gcc
GCC_WARNS := -Wall -Wextra -Wconversion -pedantic -Wcast-qual -Wcast-align -Wwrite-strings
RISCV_GCC_OPTS ?= -march=rv32i -mabi=ilp32 -static -mcmodel=medany -fvisibility=hidden -Tsections.ld -nostdlib -nolibc -nostartfiles ${GCC_WARNS} ${INCL} -fno-builtin 
RISCV_OBJDUMP ?= $(RISCV_PREFIX)objdump --disassemble-all --disassemble-zeroes --section=.text --section=.text.startup --section=.text.init --section=.data
RISCV_OBJCOPY ?= $(RISCV_PREFIX)objcopy -O verilog
RISCV_HEXGEN ?= 'BEGIN{output=0;}{gsub("\r", "", $$(NF)); if($$1 ~/@/)	\
				{if ($$1 ~/@00000000/) {output=code;} else {output=1- code;};\
				gsub("@","0x",$$1); addr=strtonum($$1); if (output==1)\
				{printf "@%08x\n",(addr%262144)/4;}}\
				else {if (output==1) { for(i=1;i<NF;i+=4)\
				print $$(i+3)$$(i+2)$$(i+1)$$i;}}}'
RISCV_MIFGEN ?= 'BEGIN{printf "WIDTH=32;\nDEPTH=%d;\n\nADDRESS_RADIX=HEX;\
				\nDATA_RADIX=HEX;\n\nCONTENT BEGIN\n",depth ; addr=0;} {\
				gsub("\r","",$$(NF)); if ($$1 ~/@/) { sub("@","0x",$$1);\
				addr=strtonum($$1);} else {printf "%04X : %s;\n", addr, $$1;\
				addr=addr+1;}} END{print "END\n";}'

CSRCS = $(wildcard ./src/*.S)
SRCS := $(wildcard ./src/*.c)
OBJS := $(SRCS:%.c=%.o) $(CSRCS:%.S=%.o)
EXEC := main

./src/do_irq.o: ./src/do_irq.S
	$(RISCV_GCC) $(RISCV_GCC_OPTS) -c -o $@ $<

.c.o:
	$(RISCV_GCC) -c $(RISCV_GCC_OPTS) $< -o $@

${EXEC}.elf : $(OBJS)
	${RISCV_GCC} ${RISCV_GCC_OPTS} -e entry $(OBJS) -o $@
	${RISCV_OBJDUMP} ${EXEC}.elf > ${EXEC}.dump

${EXEC}.tmp: ${EXEC}.elf
	$(RISCV_OBJCOPY) $< $@

${EXEC}.hex: ${EXEC}.tmp
	awk -v code=1 $(RISCV_HEXGEN) $< > $@
	awk -v code=0 $(RISCV_HEXGEN) $< > ${EXEC}_d.hex

${EXEC}.mif: ${EXEC}.hex
	awk -v depth=65536 ${RISCV_MIFGEN} $< > $@
	awk -v depth=32768 ${RISCV_MIFGEN} ${EXEC}_d.hex > ${EXEC}_d.mif
	mv main* bin/

.PHONY: all clean

all: ${EXEC}.mif

clean:
	rm -f *.o
	rm -f *.dump
	rm -f *.tmp
	rm -f *.elf
	rm -f *.hex
	rm -f *.mif
	rm -f src/*.o