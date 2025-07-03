#ifndef SHA256_H
#define SHA256_H

#include <stdint.h>

void sha256_calculate(const uint8_t *data, uint32_t len, uint8_t *hash);

#endif
