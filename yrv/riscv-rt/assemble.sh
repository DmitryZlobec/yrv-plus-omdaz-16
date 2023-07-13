#!/bin/bash

set -euxo pipefail

crate=riscv-rt

# remove existing blobs because otherwise this will append object files to the old blobs
rm -f bin/*.a

exts=('izbs')

for ext in ${exts[@]}
do
    case $ext in

        *'d'*)
            abi='d'
            ;;
        
        *'f'*)
            abi='f'
            ;;
        
        *)
            abi=''
            ;;
    esac

    riscv-none-elf-gcc -ggdb3 -fdebug-prefix-map=$(pwd)=/riscv-rt -c -mabi=ilp32${abi} -march=rv32${ext} asm/crt0.s -o bin/crt0.o
    riscv-none-elf-gcc -ggdb3 -fdebug-prefix-map=$(pwd)=/riscv-rt -c -mabi=ilp32${abi} -march=rv32${ext} asm/dbg_vec.s -o bin/dbg_vec.o
    riscv-none-elf-gcc -ggdb3 -fdebug-prefix-map=$(pwd)=/riscv-rt -c -mabi=ilp32${abi} -march=rv32${ext} asm/dex_vec.s -o bin/dex_vec.o
    riscv-none-elf-gcc -ggdb3 -fdebug-prefix-map=$(pwd)=/riscv-rt -c -mabi=ilp32${abi} -march=rv32${ext} asm/eset_led.s -o bin/eset_led.o
    riscv-none-elf-gcc -ggdb3 -fdebug-prefix-map=$(pwd)=/riscv-rt -c -mabi=ilp32${abi} -march=rv32${ext} asm/nmi_vec.s -o bin/nmi_vec.o
    riscv-none-elf-gcc -ggdb3 -fdebug-prefix-map=$(pwd)=/riscv-rt -c -mabi=ilp32${abi} -march=rv32${ext} asm/trap_ack.s -o bin/trap_ack.s.o

    riscv-none-elf-ar crs bin/riscv32i-unknown-none-elf.a bin/crt0.o bin/dbg_vec.o bin/dex_vec.o  bin/eset_led.o  bin/nmi_vec.o bin/trap_ack.s.o

    ##s-mode
    #riscv-none-elf-gcc -DSMODE -ggdb3 -fdebug-prefix-map=$(pwd)=/riscv-rt -c -mabi=ilp32${abi} -march=rv32${ext} asm.S -o bin/$crate.o
    #riscv-none-elf-ar crs bin/riscv32${ext}-unknown-none-elf-smode.a bin/$crate.o

done

rm bin/crt0.o
rm bin/dbg_vec.o
rm bin/dex_vec.o
rm bin/eset_led.o
rm bin/nmi_vec.o
rm bin/trap_ack.s.o