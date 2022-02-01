cmake_minimum_required(VERSION 3.14)

project(GridChallenge VERSION 0.1 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(QT_VERSION_MAJOR 5)
message(STATUS "Qt dir is: ${Qt5_DIR}")
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick Network REQUIRED)


set(PROJECT_SOURCES
        staticfetch.cpp
        main.cpp
        qml.qrc
)

add_executable(GridChallenge
    ${PROJECT_SOURCES}
)

target_compile_definitions(GridChallenge
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(GridChallenge
  PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick)

set_target_properties(GridChallenge PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
)

