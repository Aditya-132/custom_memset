.section .text
.global custom_memset

custom_memset:
    mv t1, a0          # Copy destination pointer
    beqz a2, done      # If length is zero, return immediately

    # If __riscv_misaligned_avoid == 1, enforce alignment before word stores
    andi t2, t1, 3     # Check if t1 is word-aligned (t1 % 4)
    beqz t2, word_set  # If already aligned, jump to word stores

# Align the pointer first by storing individual bytes
align_loop:
    sb a1, 0(t1)       # Store single byte
    addi t1, t1, 1     # Move to next byte
    addi a2, a2, -1    # Reduce byte count
    andi t2, t1, 3     # Check alignment
    beqz t2, word_set  # If aligned, proceed to word stores
    beqz a2, done      # If all bytes are processed, return
    j align_loop

# Now store in 32-bit (4-byte) words
word_set:
    li t3, 0x01010101  # Prepare word mask with repeated byte values
    mul t3, a1, t3     # Fill all 4 bytes of the word with a1
    srli t4, a2, 2     # Get number of full words (a2 / 4)

word_loop:
    beqz t4, remainder # If no full words left, go to remainder handling
    sw t3, 0(t1)       # Store 4-byte word
    addi t1, t1, 4     # Move pointer ahead by 4
    addi t4, t4, -1    # Decrease word count
    j word_loop        # Continue storing words

# Handle remaining bytes (less than 4)
remainder:
    andi a2, a2, 3     # Get number of leftover bytes (a2 % 4)
    beqz a2, done      # If no remaining bytes, return

byte_loop:
    sb a1, 0(t1)       # Store last few bytes
    addi t1, t1, 1
    addi a2, a2, -1
    bnez a2, byte_loop # Continue if more bytes remain

done:
    ret                # Return
