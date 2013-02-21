TARGET = arm-none-eabi

#FLAGS = -mcpu=arm926ej-s -g 
FLAGS = -mthumb -mcpu=cortex-m3 -g 

AS = $(TARGET)-as
LD = $(TARGET)-ld
CC = $(TARGET)-gcc
DB = $(TARGET)-gdb

all: core_cm3.o system_stm32f10x.o startup.o

startup.o: CMSIS/startup_stm32f10x_ld_vl.s Makefile
	$(AS) $(FLAGS) -o $@ -c $<

system_stm32f10x.o: CMSIS/system_stm32f10x.c CMSIS/system_stm32f10x.h CMSIS/stm32f10x.h Makefile
	$(CC) $(FLAGS) -o $@ -c $<

core_cm3.o: CMSIS/core_cm3.c CMSIS/core_cm3.h Makefile
	$(CC) $(FLAGS) -o $@ -c $<

#	$(AS) $(FLAGS) s.s -o s.o
#	$(CC) $(FLAGS) -O1 -c -o c.o c.c
#	$(LD) -T ld.ld s.o c.o -o elf.elf
#	$(TARGET)-objdump -d elf.elf
#	$(TARGET)-objcopy -O binary elf.elf bin.bin

clean:
	rm *.o *.elf *.bin

#debug: bin.bin elf.elf
#	C:\ARM\Qemu\qemu-system-armw.exe -cpu cortex-m3 -kernel bin.bin -s -S
#	qemu-arm -cpu cortex-m3 -B 0x08000000 -g 1234 CMSIS_example.out
#qemu-system-armw -M lm3s811evb -kernel bin.bin -s -S 
# -cpu cortex-m3 -kernel bin.bin -s -S
