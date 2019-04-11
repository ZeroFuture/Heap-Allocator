//
// Created by Zhidong Qu on 2019-03-13.
//

#include <stdio.h>
#include <stdbool.h>
#include <stddef.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include "memlib.h"
#include "mm_heap.h"

//Each block has 4 nodes with the allocated memory which is aligned with the size of the node.
//| header node | prev node | next node | allocated memory | footer node |

//Utilizing prev and next node to construct a DDL for the free list in heap
//A head and tail dummy blocks in the heap memory pool are also use to simplify the DDL traversal
typedef union Node { //union for memory sharing
    struct {
        size_t is_alloc: 1; //flag as an allocation indicator, 1 if allocated, 0 if free
        size_t blk_size: 8 * sizeof(size_t) - 1; //size of the block
    } info;
    union Node *p; //pointer that points to the next free Node in free list
    max_align_t max_align; // force align the Node size to be max_align_t
} Node;

static const size_t MIN_BLOCK_SIZE = 4;  // header prev next footer
static Node *freep = NULL; //free list ptr

//function signatures, forward declarations.

//free the block given block pointer
static void free_block(Node *bp);
//get a free block given size
static Node *get_block(size_t nunits);
//find the allocated block given payload (allocated) pointer
static Node *find_block(void *ap);
//reset heap
static void reset_heap(void);
//extend the heap given desired size
static Node *extend_heap(size_t nunits);

//block ptr to payload ptr
inline static void *bp_to_ap(Node *bp) {
    return bp + 1;
}

//payload ptr to block ptr
inline static Node *ap_to_bp(void *ap) {
    return (Node*)ap - 1;
}

//given header pointer and block size return footer pointer
inline static Node *header_to_footer(Node *bp) {
    return bp + bp->info.blk_size - 1;
}

//byte to Node size unit
inline static size_t byte_to_unit(size_t nbytes) {
    return (nbytes + sizeof(Node) - 1) / sizeof(Node);
}

//Node size unit to byte
inline static size_t unit_to_byte(size_t nunits) {
    return nunits * sizeof(Node);
}

//unlink a block from the free list
inline static void unlink_from_flist(Node *bp) {
    //remove bp from flist
    Node *prev = (bp + 1)->p;
    Node *next = (bp + 2)->p;
    (prev + 2)->p = next;
    (next + 1)->p = prev;
}

//link a block into free list
inline static void link_to_flist(Node *bp) {
    //next free block
    Node *next = (freep + 2)->p;
    //link inserted block to free list
    (bp + 1)->p = freep;
    (bp + 2)->p = next;
    //relink original free ptr and next ptr
    (freep + 2)->p = (next + 1)->p = bp;
}

//Initialize memory allocator
void mm_init() {
    if (freep == NULL) {
        mem_init();
        reset_heap();
    }
}

//Deinitialize memory allocator
void mm_deinit() {
    mem_deinit();
    freep = NULL;
}

//Reset memory allocator
void mm_reset() {
    if (freep == NULL) mm_init();
    else {
        mem_reset_brk();
        reset_heap();
    }
}

//malloc nbytes to user
void *mm_malloc(size_t nbytes) {
    if (freep == NULL) mm_init();
    //2 for header and footer
    size_t nunits = byte_to_unit(nbytes) + 2;
    if (nunits < MIN_BLOCK_SIZE) nunits = MIN_BLOCK_SIZE;
    Node *bp = get_block(nunits);
    if (bp == NULL) {
        errno = ENOMEM;
        return NULL;
    }
    return bp_to_ap(bp);
}

//Free the block given pointer to the payload
void mm_free(void *ap) {
    if (ap != NULL) {
        Node *bp = find_block(ap);
        if (bp == NULL) errno = EFAULT;
        else free_block(bp);
    }
}

//Reallocate the block given payload pointer and new size to reallocate.
void *mm_realloc(void *ap, size_t nbytes) {
    if (ap == NULL) return mm_malloc(nbytes);
    Node *bp = find_block(ap);
    if (bp == NULL) {
        errno = EFAULT;
        return NULL;
    }
    //current block size
    size_t cur_size = bp->info.blk_size;
    //requested block size in node unit
    size_t requested_size = byte_to_unit(nbytes) + 2;
    //requested smaller or equal to current size, no need to move
    if (requested_size <= cur_size) return ap;
    //allocate a new block with requested size
    Node *new_bp = get_block(requested_size);
    //if allocation failed, return NULL
    if (new_bp == NULL) return NULL;
    //move the cur block to new allocated block
    void *new_ap = bp_to_ap(new_bp);
    //move the block except header and footer (only payload)
    size_t aligned_bytes = unit_to_byte(cur_size - 2);
    memcpy(new_ap, ap, aligned_bytes);
    //put cur block to free list
    free_block(bp);
    return new_ap;
}

//Get total free memory size
size_t mm_getfree(void) {
    if (freep == NULL) {
        return 0;
    }
    Node *tmp = freep;
    size_t res = tmp[0].info.blk_size;
    while (tmp[1].p != freep) {
        if (tmp[0].info.is_alloc == 0) {  // not dummy node
            res += tmp[0].info.blk_size - 2;  // not headers/footers
            tmp = tmp[1].p;
        }
    }
    return unit_to_byte(res);
}

//free the block given block pointer
static void free_block(Node *bp) {
    //before merge combined size if the original free block size
    size_t combined_size = bp->info.blk_size;
    Node *footer = header_to_footer(bp);
    //mark cur block as freed
    bp->info.is_alloc = footer->info.is_alloc = 0;
    //check if the left adjacent block is also freed
    Node *left_footer = bp - 1;
    if (left_footer->info.is_alloc == 0) {
        //if also freed, do a merge
        //increment size
        combined_size += left_footer->info.blk_size;
        //move ptr down to the left adjacent header
        bp -= left_footer->info.blk_size;
        //remark size
        bp->info.blk_size = footer->info.blk_size = combined_size;
    } else {
        link_to_flist(bp);
    }
    freep = bp;
    //check if the right adjacent block is also freed
    Node *right_header = footer + 1;
    if (right_header->info.is_alloc == 0) {
        //if also freed, do a merge
        //unlink the right adj block from free list
        unlink_from_flist(right_header);
        //increment size
        combined_size += right_header->info.blk_size;
        //remark size
        Node *right_footer = header_to_footer(right_header);
        bp->info.blk_size = right_footer->info.blk_size = combined_size;
    }
}

//get a free block given size
static Node *get_block(size_t nunits) {
    Node *bp = freep;
    //traverse free list
    do {
        //first fit
        if (bp->info.is_alloc == 0 && bp->info.blk_size >= nunits) {
            //if large enough to split and allocate to the tail end
            if (bp->info.blk_size >= nunits + MIN_BLOCK_SIZE) {
                size_t offset = bp->info.blk_size - nunits;
                //address to be allocated
                Node *alloc_block = bp + offset;
                //split
                //remark the size of the free block
                bp->info.blk_size -= nunits;
                //mark new footer
                (alloc_block - 1)->info.blk_size = bp->info.blk_size;
                //mark payload header footer
                alloc_block->info.blk_size = nunits;
                Node *alloc_footer = header_to_footer(alloc_block);
                alloc_footer->info.blk_size = nunits;
                alloc_block->info.is_alloc = alloc_footer->info.is_alloc = 1;
                return alloc_block;
            } else { //if not enough to do a split
                //if freep is here, move freep backward to its prev
                if (freep == bp) freep = (bp + 1)->p;
                //unlink bp from free list
                unlink_from_flist(bp);
                Node *footer = header_to_footer(bp);
                bp->info.is_alloc = footer->info.is_alloc = 1;
                return bp;
            }
        }
        //move to next
        bp = (bp + 2)->p;
        //No free space for requested memory
        //extend the heap and continue
        if (bp == freep) bp = extend_heap(nunits);
    } while (bp != NULL);
    return NULL;
}

//find the allocated block given payload (allocated) pointer
static Node *find_block(void *ap) {
    if (ap == NULL || ap <= mem_heap_lo() || ap >= mem_heap_hi()) return NULL;
    //((uintptr_t)ap & (sizeof(max_align_t)-1)) == 0 is true if ap is aligned
    if (((uintptr_t)ap & (sizeof(max_align_t)-1)) == 0) {
        Node *bp = ap_to_bp(ap);
        //if allocated and at least MIN_BLOCK_SIZE
        if (bp->info.is_alloc == 1 && bp->info.blk_size >= MIN_BLOCK_SIZE) {
            Node* footer = header_to_footer(bp);
            //header and footer match
            if (bp->info.is_alloc == footer->info.is_alloc && bp->info.blk_size == footer->info.blk_size) {
                return bp;
            }
        }
    }
    //if not aligned, traverse the whole heap to find the block
    Node *bp = mem_heap_lo();
    Node *cur = bp + bp->info.blk_size;
    while ((void*)cur <= ap) {
        bp = cur;
        cur += bp->info.blk_size;
    }
    return bp->info.is_alloc == 1 ? bp : NULL;
}

//reset the heap memory
static void reset_heap() {
    //At least 5 node (dummy + next hdr) sized memory is required
    if (mem_sbrk((MIN_BLOCK_SIZE + 1) * sizeof(Node)) == NULL) return;
    //dummy block in DDL
    freep = mem_heap_lo();
    //mark dummy head and tail as allocated to protect from allocation
    freep->info.blk_size = MIN_BLOCK_SIZE;
    Node *footer = header_to_footer(freep);
    footer->info.blk_size = MIN_BLOCK_SIZE;
    freep->info.is_alloc = footer->info.is_alloc = 1;
    //only one block, link to itself
    (freep + 1)->p = (freep + 2)->p = freep;
    //mark tail block in heap memory pool
    Node *tail = freep + MIN_BLOCK_SIZE;
    tail->info.blk_size = 1;
    tail->info.is_alloc = 1;
}

//extend the heap given desired size
static Node *extend_heap(size_t nunits) {
    size_t min_alloc = byte_to_unit(mem_pagesize());
    //At least size of pagesize
    if (nunits < min_alloc) nunits = min_alloc;

    size_t nbytes = unit_to_byte(nunits);
    //request
    void *ap = mem_sbrk(nbytes);
    if (ap == (void *) -1) return NULL;
    Node *bp = ap_to_bp(ap);
    //mark new header footer
    bp->info.blk_size = nunits;
    Node *footer = header_to_footer(bp);
    footer->info.blk_size = nunits;
    bp->info.is_alloc = footer->info.is_alloc = 0;
    //move tail block
    Node *tail = bp + nunits;
    tail->info.is_alloc = 1;
    tail->info.blk_size = 1;
    //free requested block and return
    free_block(bp);
    return freep;
}

