#
# SPDX-License-Identifier: BSD-2-Clause
#

# Compiler flags
platform-cppflags-y =
platform-cflags-y = -g
platform-asflags-y = -g
platform-ldflags-y = -g

FW_TEXT_START=0x40000000

# Blobs to build
FW_DYNAMIC=y
FW_JUMP=y
ifeq ($(SUNXI_CHIP),sun20iw1p1)
FW_TEXT_START?=0x40000000
FW_JUMP_ADDR?=0x42000000
#xly
#FW_JUMP_ADDR?=0x40100000
endif

ifeq ($(SUNXI_CHIP),sun20iw2p1)
FW_TEXT_START?=0x40000000
FW_JUMP_ADDR?=0x43000000
endif
#FW_TEXT_START?=0x20000
#FW_JUMP_ADDR?=0x400000

# payload
FW_PAYLOAD=y
FW_PAYLOAD_OFFSET=0x100000
#FW_PAYLOAD_PATH=/path/to/zcore.bin
FW_PAYLOAD_ALIGN=0x1000

FW_PAYLOAD_FDT=d1_c906.dtb
FW_PAYLOAD_FDT_ADDR=0x5ff00000 #FDT放置在高地址 (512M - 1M)
