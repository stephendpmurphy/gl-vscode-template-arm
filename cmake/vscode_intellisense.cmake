# Make sure to create the .vscode directory if it doesn't exist
file(MAKE_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/.vscode)

# Note, if a seperate include variable is used for SDK includes you would append it here
set(INTELLISENSE_INCLDUES ${INCLUDE_DIRS})

# Generate the list of include directories as a JSON array
set(INCLUDE_DIRS_JSON "")
foreach(INCLUDE_DIR ${INTELLISENSE_INCLDUES})
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