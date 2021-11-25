// SPDX-License-Identifier: BSD-2-Clause
#include <stdint.h>

#define SUNXI_UART_THR     0
#define SUNXI_UART_RBR     0
#define SUNXI_UART_LSR     0x5 //addr:0x14
#define SUNXI_UART_USR     0x1F //addr:0x7C, sunxi_uart[SUNXI_UART_USR] => uart_base_addr + 0x7C(124)
#define SUNXI_UART_USR_NF  0x02

//??? #define SUNXI_UART_USR_RFNE  0x04
#define SUNXI_UART_USR_RFNE  0x08

static volatile uint32_t* sunxi_uart;

void sunxi_uart_putc(char ch)
{
	// UART_LSR bit:THRE
	while ((sunxi_uart[SUNXI_UART_LSR] & (1 << 5)) == 0);
	sunxi_uart[SUNXI_UART_THR] = ch;
}

int sunxi_uart_getc(void)
{
	// sbi不调用这. 见lib/utils/serial/sunxi-uart.c
	// UART_LSR bit:DR
	if ((sunxi_uart[SUNXI_UART_LSR] & (1 << 0)) == 1){
		return sunxi_uart[SUNXI_UART_RBR];
	}else{
		return -1;
	}
}

int sunxi_uart_init(unsigned long base)
{
	sunxi_uart = (volatile void *)base;
	return 0;
}
