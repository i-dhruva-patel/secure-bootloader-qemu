#include "uart.h"

#define UART0_DR *((volatile unsigned int *)0x4000C000)

void uart_init(void) {
    // QEMU UART works without config
}

void uart_print(const char *msg) {
    while (*msg) {
        UART0_DR = *msg++;
    }
}
