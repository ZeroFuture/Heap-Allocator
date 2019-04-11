# Heap-Allocator
Implemented a simple Heap Allocator with Doubly-Linked List structure to store blocks.
The following APIs are supported:

1.
/**
 * Initialize memory allocator
 */
void mm_init();

2.
/**
 * Reset memory allocator
 */
void mm_reset();

3.
/**
 * De-initialize memory allocator
 */
void mm_deinit();

4.
/**
 * Calculate the total amount of available free memory.
 *
 * @return the amount of free memory in bytes
 */
size_t mm_getfree(void);

5.
/**
 * Allocates size bytes of memory and returns a pointer to the
 * allocated memory, or NULL if request storage cannot be allocated.
 *
 * @param nbytes the number of bytes to allocate
 * @return pointer to allocated memory or NULL if not available.
 */
void *mm_malloc(size_t nbytes);

6.
/**
 * Deallocates the memory allocation pointed to by ptr.
 * if ptr is a NULL pointer, no operation is performed.
 *
 * @param ap the allocated block to free
 */
void mm_free(void *ap);

7.
/**
 * Reallocates size bytes of memory and returns a pointer to the
 * allocated memory, or NULL if request storage cannot be allocated.
 *
 * @param ap the currently allocated storage
 * @param nbytes the number of bytes to allocate
 * @return pointer to allocated memory or NULL if not available.
 */
void *mm_realloc(void *ap, size_t size);
