#!/usr/bin/env python3
import sys
import hashlib

def sign_firmware(input_file, output_file):
    with open(input_file, 'rb') as f:
        data = f.read()
    
    # Create mock signature (256 zeros) + SHA256 hash
    with open(output_file, 'wb') as f:
        f.write(b'\x00'*256)  # Fake RSA signature
        f.write(hashlib.sha256(data).digest())  # SHA256 hash
        f.write(data)  # Original firmware

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: sign_fw.py <input.bin> <output.bin>")
        sys.exit(1)
    sign_firmware(sys.argv[1], sys.argv[2])
