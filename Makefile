TARGET = arm-none-eabi
STARTUP = startup_stm32f10x_ld_vl.s

#FLAGS = -mcpu=arm926ej-s -g

CMSIS_CORE = CMSIS/CM3/CoreSupport
CMSIS_DEVICE = CMSIS/CM3/DeviceSupport/ST/STM32F10x

C_INCLUDE_PATH = -I $(CMSIS_CORE) -I $(CMSIS_DEVICE)
 
FLAGS = -mthumb -mcpu=cortex-m3 -g $(C_INCLUDE_PATH)

AS = $(TARGET)-as
LD = $(TARGET)-ld
CC = $(TARGET)-gcc
DB = $(TARGET)-gdb

all: firmware.elf

firmware.elf: core_cm3.o system_stm32f10x.o startup.o main.o ld.ld Makefile
	$(LD) -T ld.ld core_cm3.o system_stm32f10x.o startup.o -o $@
	
main.o: stm32blink/src/main.c Makefile
	$(CC) $(FLAGS) -o $@ -c $<

startup.o: $(CMSIS_DEVICE)/startup/$(STARTUP) Makefile
	$(AS) $(FLAGS) -o $@ -c $<

system_stm32f10x.o: \
	$(CMSIS_DEVICE)/system_stm32f10x.c \
	$(CMSIS_DEVICE)/system_stm32f10x.h \
	$(CMSIS_DEVICE)/stm32f10x.h \
	Makefile
	$(CC) $(FLAGS) -o $@ -c $<

core_cm3.o: CMSIS/CM3/CoreSupport/core_cm3.c CMSIS/CM3/CoreSupport/core_cm3.h Makefile
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
