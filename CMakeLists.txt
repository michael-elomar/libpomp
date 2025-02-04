cmake_minimum_required(VERSION 3.5)
project(pomp)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(BINARY_DIR ${CMAKE_SOURCE_DIR}/out/)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${BINARY_DIR}/bin/)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${BINARY_DIR}/lib/)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${BINARY_DIR}/lib/)


include_directories(
    include
)

set(
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
	src/pomp_loop_sync
    src/pomp_msg.c
    src/pomp_prot.c
    src/pomp_timer.c
    src/pomp_watchdog.c
)

add_library(pomp SHARED ${SRC})
set_target_properties(pomp PROPERTIES PUBLIC_HEADER include/libpomp.h)

#======== Install Support ========#

# Install the library
install(TARGETS ${PROJECT_NAME}
    EXPORT ${PROJECT_NAME}Targets
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    PUBLIC_HEADER DESTINATION include)

# Install the headers
install(DIRECTORY include/ DESTINATION include)

#======== Package Support ========#

# Create a package configuration file
include(CMakePackageConfigHelpers)


configure_package_config_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake/${PROJECT_NAME}Config.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
    INSTALL_DESTINATION lib/cmake/${PROJECT_NAME}
)

# Install the package configuration files
install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
    DESTINATION lib/cmake/${PROJECT_NAME}
)

# Export targets for use by other projects
install(EXPORT ${PROJECT_NAME}Targets
    FILE ${PROJECT_NAME}Targets.cmake
    NAMESPACE ${PROJECT_NAME}::
    DESTINATION lib/cmake/${PROJECT_NAME}
	)

# compile example
add_executable(ping examples/ping.c examples/ping_common.h)
target_link_libraries(ping pomp pthread rt)
# include(GNUInstallDirs)
# install(TARGETS libpomp LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR} PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
# =================================================
