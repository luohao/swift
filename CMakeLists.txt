cmake_minimum_required(VERSION 2.8)
project(pull-star CXX)

include(CheckCXXCompilerFlag)
CHECK_CXX_COMPILER_FLAG("-std=c++11" COMPILER_SUPPORTS_CXX11)
if(COMPILER_SUPPORTS_CXX11)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
else()
    CHECK_CXX_COMPILER_FLAG("-std=c++0x" COMPILER_SUPPORTS_CXX0X)
    if(COMPILER_SUPPORTS_CXX0X)
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
    else()
        message(STATUS "The compiler ${CMAKE_CXX_COMPILER} has no C++11 support. Please use a different C++ compiler.")
    endif()
endif()
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -g")

set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake-modules)

set(LIBRARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/lib)
file(MAKE_DIRECTORY ${LIBRARY_OUTPUT_PATH})

set(INCLUDE include ds-lib/include)
file(GLOB_RECURSE SOURCE_FILES src/*.cc)
include_directories(${INCLUDE})
add_library(pullstar STATIC ${SOURCE_FILES})
set_target_properties(pullstar PROPERTIES LINKER_LANGUAGE CXX)
target_link_libraries(pullstar ds)
target_link_libraries(pullstar cst)

add_subdirectory(ds-lib)
add_subdirectory(bench)
add_subdirectory(shell)
add_subdirectory(thrift)
