# Heap-Allocator

NEU CS5600 Computer System Course Project

Implemented a simple Heap Allocator with Doubly-Linked List structure to store blocks.
The following APIs are supported:

1.
 * Initialize memory allocator
 
void mm_init();

2.
 * Reset memory allocator
 
void mm_reset();

3.
 * De-initialize memory allocator
 
void mm_deinit();

4.
 * Calculate the total amount of available free memory
 
size_t mm_getfree(void);

5.
 * Allocates size bytes of memory and returns a pointer to the
   allocated memory, or NULL if request storage cannot be allocated
   
void *mm_malloc(size_t nbytes);

6.
 * Deallocates the memory allocation pointed to by ptr.
   if ptr is a NULL pointer, no operation is performed
   
void mm_free(void *ap);

7.
 * Reallocates size bytes of memory and returns a pointer to the
   allocated memory, or NULL if request storage cannot be allocated
   
void *mm_realloc(void *ap, size_t size);
