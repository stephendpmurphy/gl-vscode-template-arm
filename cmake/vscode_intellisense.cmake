# Make sure to create the .vscode directory if it doesn't exist
file(MAKE_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/.vscode)

get_target_property(LINKED_LIBRARIES ${EXECUTABLE_NAME} LINK_LIBRARIES)

if(LINKED_LIBRARIES)
    foreach(lib ${LINKED_LIBRARIES})
        get_target_property(LIBRARIES_INCLUDE_DIRS ${lib} INCLUDE_DIRECTORIES)
        if(LIBRARIES_INCLUDE_DIRS)
            set(INTELLISENSE_INCLUDES ${INTELLISENSE_INCLUDES} ${LIBRARIES_INCLUDE_DIRS})
        endif()
    endforeach()

    foreach(lib ${LINKED_LIBRARIES})
        get_target_property(INTF_LIBRARIES_INCLUDE_DIRS ${lib} INTERFACE_INCLUDE_DIRECTORIES)
        if(INTF_LIBRARIES_INCLUDE_DIRS)
            set(INTELLISENSE_INCLUDES ${INTELLISENSE_INCLUDES} ${INTF_LIBRARIES_INCLUDE_DIRS})
        endif()
    endforeach()
endif()

get_target_property(APP_INCLUDE_DIRS ${EXECUTABLE_NAME} INCLUDE_DIRECTORIES)

if(APP_INCLUDE_DIRS)
    set(INTELLISENSE_INCLUDES ${INTELLISENSE_INCLUDES} ${APP_INCLUDE_DIRS})
endif()

# Generate the list of include directories as a JSON array
set(INCLUDE_DIRS_JSON "")
foreach(INCLUDE_DIR ${INTELLISENSE_INCLUDES})
    list(APPEND INCLUDE_DIRS_JSON "\"${INCLUDE_DIR}\"")
endforeach()
string(JOIN ",\n" INCLUDE_DIRS_JSON ${INCLUDE_DIRS_JSON})

# Specify the template for the c_cpp_properties.json file
write_file(${CMAKE_CURRENT_SOURCE_DIR}/.vscode/c_cpp_properties.json
"{
    \"configurations\": [
        {
            \"name\": \"${CMAKE_BUILD_TYPE}\",
            \"includePath\": [
                ${INCLUDE_DIRS_JSON}
            ],
            \"compileCommands\": \"\$\{workspaceFolder\}/build/compile_command.json\",
            \"defines\": [\"\"],
            \"compilerPath\": \"${CMAKE_C_COMPILER}\",
            \"cStandard\": \"c99\",
            \"cppStandard\": \"c++17\",
            \"intelliSenseMode\": \"gcc-arm\"
        }
    ],
    \"version\": 1
}")
