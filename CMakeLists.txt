cmake_minimum_required(VERSION 3.16)
project(graphwl LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

find_package(PkgConfig REQUIRED)
pkg_search_module(WLROOTS REQUIRED IMPORTED_TARGET wlroots-0.21 wlroots-0.20)
pkg_check_modules(WAYLAND_SERVER REQUIRED IMPORTED_TARGET wayland-server)
pkg_check_modules(XKBCOMMON REQUIRED IMPORTED_TARGET xkbcommon)

add_subdirectory( lib )

file(GLOB SRC_FILES CONFIGURE_DEPENDS 
    "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/*.c"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/*.h"
)

add_executable(graphwl ${SRC_FILES})

target_compile_definitions(graphwl PRIVATE WLR_USE_UNSTABLE)

#target_compile_options(graphwl PRIVATE -Wall -Werror)
target_compile_options(graphwl PRIVATE -Wall)

target_link_libraries(graphwl PRIVATE
	PkgConfig::WLROOTS
	PkgConfig::WAYLAND_SERVER
	PkgConfig::XKBCOMMON
	wlrpp
)

include(GNUInstallDirs)
install(TARGETS graphwl RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
