set(DEBUG_ERASE_CMD "pyocd" "erase" "-t${MCU_TARGET}" "--chip")
set(DEBUG_FLASH_CMD "pyocd" "flash" "-t${MCU_TARGET}" "-f20000khz" "${EXECUTABLE_OUTPUT_PATH}/${EXECUTABLE_NAME}.elf")