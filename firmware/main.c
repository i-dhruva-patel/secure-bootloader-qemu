#include <stdint.h>

#define UART0_DR     *((volatile unsigned int *)0x4000C000)
#define UART0_FR     *((volatile unsigned int *)0x4000C018)

void uart_print(const char *msg) {
    while (*msg) {
        while (UART0_FR & (1 << 5)); // Wait if TX FIFO is full
        UART0_DR = *msg++;
    }
}

void firmware_main(void) {
    uart_print("🚀 Firmware running!\n");
    while (1);
}
