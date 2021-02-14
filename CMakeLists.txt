cmake_minimum_required(VERSION 3.11.0)

project(Z3D VERSION 2.4.0 LANGUAGES CXX CUDA)

# set(CMAKE_AUTOMOC ON)
# set(CMAKE_AUTORCC ON)
# set(CMAKE_AUTOUIC ON)

# Check for dependencies
# find_package(Qt5 COMPONENTS Core Gui Concurrent REQUIRED)
# find_package(VTK CONFIG REQUIRED)
# find_package(PCL CONFIG REQUIRED)
# find_package(OpenCV REQUIRED)
# find_package(cupoch CONFIG REQUIRED)
# find_package(CUDA)

# Mark all public headers
file(GLOB_RECURSE ALL_HEADER_FILES "z3d/include/Z3D/*.h")

include_directories("z3d/include")

# Define the library
add_library(${PROJECT_NAME} SHARED
 z3d/include/Z3D/core/pointcloud.h
 z3d/src/core/pointcloud.cpp
 )

set_target_properties(${PROJECT_NAME} PROPERTIES 
    CXX_STANDARD 17
    DEBUG_POSTFIX "_d"
    DEFINE_SYMBOL "CADSTAR_3D_LIBRARY"
    # CUDA Settings
    CUDA_ARCHITECTURES "61;75"
    CUDA_SEPARABLE_COMPILATION OFF
)

target_include_directories(${PROJECT_NAME}
    PUBLIC 
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}> 
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/z3d/include>
    PRIVATE 
        ${CMAKE_CURRENT_SOURCE_DIR}/src
)

# target_link_libraries(${PROJECT_NAME} 
#     PUBLIC 
#         Qt5::Core Qt5::Gui Qt5::Concurrent
#         opencv_core opencv_imgproc
#         ${VTK_LIBRARIES}
#         ${PCL_LIBRARIES}
#         cupoch::cupoch
# )

# Installation

include(GNUInstallDirs)

export(TARGETS ${PROJECT_NAME} FILE "${PROJECT_NAME}Targets.cmake")

install(TARGETS ${PROJECT_NAME}
    EXPORT "${PROJECT_NAME}Targets"
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

install(DIRECTORY "z3d/include/${PROJECT_NAME}" DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
    "${PROJECT_NAME}ConfigVersion.cmake"
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY SameMajorVersion
)

install(EXPORT "${PROJECT_NAME}Targets"
    FILE "${PROJECT_NAME}Targets.cmake"
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/
)

install(FILES "${PROJECT_NAME}Config.cmake" "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/
)