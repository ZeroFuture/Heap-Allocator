# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.13

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /Applications/CLion.app/Contents/bin/cmake/mac/bin/cmake

# The command to remove a file.
RM = /Applications/CLion.app/Contents/bin/cmake/mac/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/zeroqu/Desktop/Studyspace/CS5600/assignment-3-zhidongqu

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/zeroqu/Desktop/Studyspace/CS5600/assignment-3-zhidongqu/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/mm_simple.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/mm_simple.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/mm_simple.dir/flags.make

CMakeFiles/mm_simple.dir/src/test_heap.c.o: CMakeFiles/mm_simple.dir/flags.make
CMakeFiles/mm_simple.dir/src/test_heap.c.o: ../src/test_heap.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/zeroqu/Desktop/Studyspace/CS5600/assignment-3-zhidongqu/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/mm_simple.dir/src/test_heap.c.o"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/mm_simple.dir/src/test_heap.c.o   -c /Users/zeroqu/Desktop/Studyspace/CS5600/assignment-3-zhidongqu/src/test_heap.c

CMakeFiles/mm_simple.dir/src/test_heap.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/mm_simple.dir/src/test_heap.c.i"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/zeroqu/Desktop/Studyspace/CS5600/assignment-3-zhidongqu/src/test_heap.c > CMakeFiles/mm_simple.dir/src/test_heap.c.i

CMakeFiles/mm_simple.dir/src/test_heap.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/mm_simple.dir/src/test_heap.c.s"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/zeroqu/Desktop/Studyspace/CS5600/assignment-3-zhidongqu/src/test_heap.c -o CMakeFiles/mm_simple.dir/src/test_heap.c.s

CMakeFiles/mm_simple.dir/src/memlib.c.o: CMakeFiles/mm_simple.dir/flags.make
CMakeFiles/mm_simple.dir/src/memlib.c.o: ../src/memlib.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/zeroqu/Desktop/Studyspace/CS5600/assignment-3-zhidongqu/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/mm_simple.dir/src/memlib.c.o"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/mm_simple.dir/src/memlib.c.o   -c /Users/zeroqu/Desktop/Studyspace/CS5600/assignment-3-zhidongqu/src/memlib.c

CMakeFiles/mm_simple.dir/src/memlib.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/mm_simple.dir/src/memlib.c.i"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/zeroqu/Desktop/Studyspace/CS5600/assignment-3-zhidongqu/src/memlib.c > CMakeFiles/mm_simple.dir/src/memlib.c.i

CMakeFiles/mm_simple.dir/src/memlib.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/mm_simple.dir/src/memlib.c.s"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/zeroqu/Desktop/Studyspace/CS5600/assignment-3-zhidongqu/src/memlib.c -o CMakeFiles/mm_simple.dir/src/memlib.c.s

CMakeFiles/mm_simple.dir/src/mm_simple_heap.c.o: CMakeFiles/mm_simple.dir/flags.make
CMakeFiles/mm_simple.dir/src/mm_simple_heap.c.o: ../src/mm_simple_heap.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/zeroqu/Desktop/Studyspace/CS5600/assignment-3-zhidongqu/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object CMakeFiles/mm_simple.dir/src/mm_simple_heap.c.o"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/mm_simple.dir/src/mm_simple_heap.c.o   -c /Users/zeroqu/Desktop/Studyspace/CS5600/assignment-3-zhidongqu/src/mm_simple_heap.c

CMakeFiles/mm_simple.dir/src/mm_simple_heap.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/mm_simple.dir/src/mm_simple_heap.c.i"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/zeroqu/Desktop/Studyspace/CS5600/assignment-3-zhidongqu/src/mm_simple_heap.c > CMakeFiles/mm_simple.dir/src/mm_simple_heap.c.i

CMakeFiles/mm_simple.dir/src/mm_simple_heap.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/mm_simple.dir/src/mm_simple_heap.c.s"
	/Library/Developer/CommandLineTools/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/zeroqu/Desktop/Studyspace/CS5600/assignment-3-zhidongqu/src/mm_simple_heap.c -o CMakeFiles/mm_simple.dir/src/mm_simple_heap.c.s

# Object files for target mm_simple
mm_simple_OBJECTS = \
"CMakeFiles/mm_simple.dir/src/test_heap.c.o" \
"CMakeFiles/mm_simple.dir/src/memlib.c.o" \
"CMakeFiles/mm_simple.dir/src/mm_simple_heap.c.o"

# External object files for target mm_simple
mm_simple_EXTERNAL_OBJECTS =

mm_simple: CMakeFiles/mm_simple.dir/src/test_heap.c.o
mm_simple: CMakeFiles/mm_simple.dir/src/memlib.c.o
mm_simple: CMakeFiles/mm_simple.dir/src/mm_simple_heap.c.o
mm_simple: CMakeFiles/mm_simple.dir/build.make
mm_simple: CMakeFiles/mm_simple.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/zeroqu/Desktop/Studyspace/CS5600/assignment-3-zhidongqu/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Linking C executable mm_simple"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/mm_simple.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/mm_simple.dir/build: mm_simple

.PHONY : CMakeFiles/mm_simple.dir/build

CMakeFiles/mm_simple.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/mm_simple.dir/cmake_clean.cmake
.PHONY : CMakeFiles/mm_simple.dir/clean

CMakeFiles/mm_simple.dir/depend:
	cd /Users/zeroqu/Desktop/Studyspace/CS5600/assignment-3-zhidongqu/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/zeroqu/Desktop/Studyspace/CS5600/assignment-3-zhidongqu /Users/zeroqu/Desktop/Studyspace/CS5600/assignment-3-zhidongqu /Users/zeroqu/Desktop/Studyspace/CS5600/assignment-3-zhidongqu/cmake-build-debug /Users/zeroqu/Desktop/Studyspace/CS5600/assignment-3-zhidongqu/cmake-build-debug /Users/zeroqu/Desktop/Studyspace/CS5600/assignment-3-zhidongqu/cmake-build-debug/CMakeFiles/mm_simple.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/mm_simple.dir/depend

