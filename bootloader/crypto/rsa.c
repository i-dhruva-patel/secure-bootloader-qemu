#include "rsa.h"
#include "../uart.h"

// Fallback if key doesn't exist
#ifndef __KEY_DATA_DEFINED__
const uint8_t rsa_pub_key[256] = {0};
#endif

int rsa_verify_signature(uint32_t fw_addr) {
    // TODO: Implement proper verification
    return 1; // Temporarily always return success
}
