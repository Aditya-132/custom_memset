CC = riscv64-linux-gnu-gcc
AS = riscv64-linux-gnu-as
LD = riscv64-linux-gnu-ld
QEMU = qemu-riscv64

SRC_DIR = src
BUILD_DIR = build
TEST_DIR = test

CFLAGS = -static  # Ensure static linking

all: $(BUILD_DIR)/custom_memset

$(BUILD_DIR)/custom_memset: $(BUILD_DIR)/main.o $(BUILD_DIR)/memset.o
	mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -o $@ $^

$(BUILD_DIR)/main.o: $(SRC_DIR)/main.c
	mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/memset.o: $(SRC_DIR)/memset.S
	mkdir -p $(BUILD_DIR)
	$(AS) -c $< -o $@

$(BUILD_DIR)/test_memset: $(TEST_DIR)/test_memset.c $(BUILD_DIR)/memset.o
	mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -o $@ $^

test: $(BUILD_DIR)/test_memset
	$(QEMU) $(BUILD_DIR)/test_memset

run: $(BUILD_DIR)/custom_memset
	$(QEMU) $(BUILD_DIR)/custom_memset

clean:
	rm -rf $(BUILD_DIR)/*
