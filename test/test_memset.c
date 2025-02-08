#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <stdint.h>

// Prototype for the assembly function
void* custom_memset(void* dest, int val, size_t len);

// Helper function to test memset correctness
void test_memset(size_t size, int value) {
    unsigned char* expected = (unsigned char*)malloc(size);
    unsigned char* actual = (unsigned char*)malloc(size);
    
    if (!expected || !actual) {
        printf("Memory allocation failed!\n");
        exit(1);
    }

    // Use standard memset for reference
    memset(expected, value, size);
    
    // Use custom memset
    custom_memset(actual, value, size);

    // Compare results
    assert(memcmp(expected, actual, size) == 0 && "Test failed: custom_memset does not match standard memset");

    // Cleanup
    free(expected);
    free(actual);
}

// Run multiple test cases
void run_tests() {
    printf("Running unit tests...\n");

    test_memset(1, 0);        // Edge case: smallest size
    test_memset(5, 255);      // Small size
    test_memset(10, 100);     // Small size
    test_memset(100, 50);     // Medium size
    test_memset(1024, 200);   // Large size
    test_memset(4096, 0xAA);  // Very large block

    printf("All tests passed!\n");
}

int main() {
    run_tests();
    return 0;
}
