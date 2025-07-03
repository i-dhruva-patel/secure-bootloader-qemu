# Toolchain
CC = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy
SIZE = arm-none-eabi-size

# Flags
CFLAGS = -mcpu=cortex-m3 -mthumb -Wall -ffunction-sections -fdata-sections -nostdlib
CFLAGS += -Ibootloader -Ibootloader/crypto -Ikeys
CFLAGS += -mno-thumb-interwork
# Modify this line in your Makefile
CFLAGS = -mcpu=cortex-m3 -mthumb -Wall -ffunction-sections -fdata-sections -nostdlib
CFLAGS += -Ibootloader -Ibootloader/crypto -Ikeys  # Added -Ikeys
# Sources
BOOT_SRCS = bootloader/main.c \
           bootloader/startup.s \
           bootloader/uart.c \
           $(wildcard bootloader/crypto/*.c)

FW_SRCS = firmware/main.c

# Outputs
BOOT_OUT = bootloader.elf
FW_OUT = firmware.elf
FW_BIN = firmware.bin
FW_SIGNED = firmware-signed.bin

# Rules
all: $(BOOT_OUT) $(FW_SIGNED)

$(BOOT_OUT): $(BOOT_SRCS)
	$(CC) $(CFLAGS) -T linker/bootloader.ld $^ -o $@

$(FW_OUT): $(FW_SRCS)
	$(CC) $(CFLAGS) -T linker/firmware.ld $^ -o $@

$(FW_BIN): $(FW_OUT)
	$(OBJCOPY) -O binary $< $@

$(FW_SIGNED): $(FW_BIN)
	@echo "Signing firmware..."
	@python3 tools/sign_fw.py $< $@ || (echo "Warning: Using unsigned firmware"; cp $< $@)

keys/rsa_priv.pem:
	mkdir -p keys
	openssl genrsa -out $@ 2048
	openssl rsa -in $@ -pubout -outform DER -out keys/rsa_pub.der
	xxd -i keys/rsa_pub.der > keys/rsa_pub.h

run: $(BOOT_OUT) $(FW_SIGNED)
	qemu-system-arm -M lm3s6965evb -nographic \
		-kernel $(BOOT_OUT) \
		-device loader,file=$(FW_SIGNED),addr=0x4000

clean:
	rm -f $(BOOT_OUT) $(FW_OUT) $(FW_BIN) $(FW_SIGNED)

.PHONY: all clean run
