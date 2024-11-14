# Make sure to create the .vscode directory if it doesn't exist
file(MAKE_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/.vscode)

string(TOLOWER ${DEBUG_TOOLSET} DEBUG_SERVER_TYPE)

# Specify the template for the c_cpp_properties.json file
write_file(${CMAKE_CURRENT_SOURCE_DIR}/.vscode/launch.json
"{
    \"version\":\"0.2.0\",
    \"configurations\":[
    {
       \"name\":\"${DEBUG_TOOLSET}\",
       \"type\":\"cortex-debug\",
       \"request\":\"launch\",
       \"servertype\":\"${DEBUG_SERVER_TYPE}\",
       \"cwd\":\"\",
       \"executable\":\"${EXECUTABLE_OUTPUT_PATH}/${EXECUTABLE_NAME}.elf\",
       \"device\":\"${MCU_TARGET}\",
        \"interface\": \"${DEBUG_INTERFACE}\",
       \"v1\":false,
       \"serverArgs\":[
           \"--nogui\"
       ],"
)

if(${ENABLE_SEGGER_RTT} AND (${DEBUG_SERVER_TYPE} STREQUAL "jlink"))

write_file(${CMAKE_CURRENT_SOURCE_DIR}/.vscode/launch.json
"       \"rttConfig\":{
            \"enabled\":true,
            \"address\":\"auto\",
            \"decoders\":[{
            \"port\":0,
            \"type\":\"console\"
            }]
        }
    }]
}" APPEND)

else()

write_file(${CMAKE_CURRENT_SOURCE_DIR}/.vscode/launch.json
"   }]
}" APPEND)

endif()
