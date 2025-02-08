#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

// Assembly function prototype
void* custom_memset(void* dest, int val, size_t len);

int main() {
    size_t size;
    int value;

    // Get user input
    printf("Enter the size of the array: ");
    scanf("%zu", &size);

    printf("Enter the value to set (0-255): ");
    scanf("%d", &value);

    // Allocate memory
    unsigned char* arr = (unsigned char*)malloc(size);
    if (!arr) {
        printf("Memory allocation failed!\n");
        return 1;
    }

    // Use custom memset
    custom_memset(arr, value, size);

    // Display result
    printf("Array after memset: ");
    for (size_t i = 0; i < size; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");

    // Free memory
    free(arr);

    return 0;
}
