#include "sha256.h"

void sha256_calculate(const uint8_t *data, uint32_t len, uint8_t *hash) {
    // TODO: Implement actual SHA-256
    // For now just zeros the hash
    for(int i = 0; i < 32; i++) hash[i] = 0;
}
