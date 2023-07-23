#!/bin/bash

make -j PLATFORM=generic FW_PIC=y CROSS_COMPILE=riscv64-unknown-linux-gnu-

# Output opensbi/build/platform/generic/firmware/fw_dynamic.bin
# u-boot 默认通过fw_jump.bin, 加载linux内核；也可以用fw_dynamic.bin

