cmake_minimum_required(VERSION 3.5)
project(pomp)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set (CMAKE_RUNTIME_OUTPUT_DIRECTORY ../bin/${CMAKE_BUILD_TYPE})
set (CMAKE_LIBRARY_OUTPUT_DIRECTORY ../lib/${CMAKE_BUILD_TYPE})

include_directories(
    include
)

set (
    SRC
    include/libpomp.h
	src/pomp_addr.c
	src/pomp_buffer.c
	src/pomp_conn.c
	src/pomp_ctx.c
	src/pomp_decoder.c
	src/pomp_encoder.c
	src/pomp_evt.c
	src/pomp_log.c
	src/pomp_loop.c
	src/pomp_msg.c
	src/pomp_prot.c
	src/pomp_timer.c
	src/pomp_watchdog.c
)

add_library(pomp SHARED ${SRC})
set_target_properties(pomp PROPERTIES PUBLIC_HEADER include/libpomp.h)


# compile example
add_executable(ping examples/ping.c examples/ping_common.h)
target_link_libraries(ping pomp pthread rt)
# include(GNUInstallDirs)
# install(TARGETS libpomp LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR} PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
# =================================================
