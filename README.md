# Custom memset Implementation (RISC-V)

## Overview
This project implements a custom `memset` function in RISC-V assembly. The application is compiled using the GNU RISC-V toolchain and can be executed using QEMU.

## Features
- **Optimized memset implementation**: Uses word-aligned memory operations when possible for better performance.
- **Supports both aligned and unaligned memory accesses**.
- **Unit tests included**: Ensures correctness of implementation.
- **Compatible with GNU RISC-V toolchain**.
- **Runs in QEMU**: Emulate RISC-V execution on x86 machines.

## Prerequisites
Ensure you have the following installed:

- RISC-V GNU Toolchain
- GNU Make
- QEMU for RISC-V

### Installing RISC-V GNU Toolchain
If you haven't installed it yet, you can build the toolchain from source:
```sh
# Clone the RISC-V GNU Toolchain repository
git clone --recursive https://github.com/riscv/riscv-gnu-toolchain
cd riscv-gnu-toolchain

# Build the toolchain for bare-metal targets
./configure --prefix=/opt/riscv64-gnu --target=riscv64-unknown-elf
make -j$(nproc)
```

Add the toolchain to your path:
```sh
export PATH=/opt/riscv64-gnu/bin:$PATH
```

## Project Structure
```
memset_project/
│── src/
│   ├── main.c          # Entry point for the application
│   ├── memset.S        # Assembly implementation of memset
│── test/
│   ├── test_memset.c   # Unit tests for memset
│── build/              # Compiled binaries (generated during build)
│── Makefile            # Build system
│── README.md           # Project documentation
```

## Building the Project
1. Clone the repository:
   ```sh
   git clone https://github.com/yourusername/memset_project.git
   cd memset_project
   ```

2. Build the application:
   ```sh
   make
   ```

## Running the Application
Run the compiled binary using QEMU:
```sh
make run
```

Alternatively, you can manually execute:
```sh
qemu-riscv64 build/custom_memset
```

## Testing
To verify correctness, run the unit tests:
```sh
make test
```
This will compile and execute the test program, comparing the custom `memset` function against the standard C library implementation.

## Cleaning Up
To remove all compiled files:
```sh
make clean
```

## Troubleshooting
- If `stdio.h` or other standard headers are missing, verify that your GNU toolchain installation is correct and that it includes standard libraries.
- If QEMU fails to execute the binary, ensure that `qemu-riscv64` is installed and correctly configured.
- For permission issues, try running `export PATH=/opt/riscv64-gnu/bin:$PATH` again.

## Contributing
Contributions are welcome! Feel free to open issues or submit pull requests.

1. Fork the repository.
2. Create a new branch.
3. Make your changes.
4. Submit a pull request.

## License
This project is licensed under the MIT License.

