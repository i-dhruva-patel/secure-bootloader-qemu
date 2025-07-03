.syntax unified
.cpu cortex-m3
.thumb

/* Vector Table */
.section .isr_vector, "a"
.align 2
.global _vector_table
_vector_table:
    .word _stack_top         /* Initial stack pointer (set in linker script) */
    .word _reset_handler + 1 /* Reset handler (Thumb mode) */
    .word _nmi_handler + 1   /* NMI handler */
    .word _hardfault_handler + 1 /* HardFault handler */
    .word _memmanage_handler + 1 /* MemManage handler */
    .word _busfault_handler + 1  /* BusFault handler */
    .word _usagefault_handler + 1 /* UsageFault handler */
    .word 0                   /* Reserved */
    .word 0                   /* Reserved */
    .word 0                   /* Reserved */
    .word 0                   /* Reserved */
    .word _svc_handler + 1    /* SVCall handler */
    .word _debugmon_handler + 1 /* DebugMon handler */
    .word 0                   /* Reserved */
    .word _pendsv_handler + 1 /* PendSV handler */
    .word _systick_handler + 1 /* SysTick handler */

/* Minimal exception handlers */
.section .text._default_handler
.thumb_func
.global _default_handler
_default_handler:
    b .

/* Define weak aliases for all handlers */
.weak _nmi_handler
.thumb_set _nmi_handler,_default_handler

.weak _hardfault_handler
.thumb_set _hardfault_handler,_default_handler

.weak _memmanage_handler
.thumb_set _memmanage_handler,_default_handler

.weak _busfault_handler
.thumb_set _busfault_handler,_default_handler

.weak _usagefault_handler
.thumb_set _usagefault_handler,_default_handler

.weak _svc_handler
.thumb_set _svc_handler,_default_handler

.weak _debugmon_handler
.thumb_set _debugmon_handler,_default_handler

.weak _pendsv_handler
.thumb_set _pendsv_handler,_default_handler

.weak _systick_handler
.thumb_set _systick_handler,_default_handler

/* Reset Handler */
.section .text._reset_handler
.thumb_func
.global _reset_handler
_reset_handler:
    /* Initialize stack pointer */
    ldr r0, =_stack_top
    mov sp, r0

    /* Call SystemInit (if you have one) */
    /* bl SystemInit */

    /* Call main bootloader function */
    bl bootloader_main

    /* Infinite loop if bootloader_main returns */
    b .
