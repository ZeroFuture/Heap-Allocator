cmake_minimum_required(VERSION 3.13)
project(Assignment3 C)

set(CMAKE_C_STANDARD 11)

add_executable(mm_simple ./src/test_heap.c ./src/memlib.c ./src/mm_simple_heap.c)
add_executable(mm_malloc ./src/test_heap.c ./src/memlib.c ./src/mm_malloc_heap.c)
add_executable(mm_kr ./src/test_heap.c ./src/memlib.c ./src/mm_kr_heap.c)
add_executable(mm_dlink ./src/test_heap.c ./src/memlib.c ./src/mm_dlink_heap.c src/mm_dlink_heap.c)