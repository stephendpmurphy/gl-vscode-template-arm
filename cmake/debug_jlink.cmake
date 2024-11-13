set(DEBUG_ERASE_CMD "JLinkExe" "-commanderscript" "${CMAKE_CURRENT_SOURCE_DIR}/Erase.jlink")
set(DEBUG_FLASH_CMD "JLinkExe" "-commanderscript" "${CMAKE_CURRENT_SOURCE_DIR}/Flash.jlink")

write_file(${CMAKE_CURRENT_SOURCE_DIR}/Erase.jlink
"device ${MCU_TARGET}
speed 4000
r
erase
r
exit"
)

write_file(${CMAKE_CURRENT_SOURCE_DIR}/Flash.jlink
"device ${MCU_TARGET}
speed 4000
r
loadfile ${EXECUTABLE_OUTPUT_PATH}/${EXECUTABLE_NAME}.hex
r
g
exit"
)