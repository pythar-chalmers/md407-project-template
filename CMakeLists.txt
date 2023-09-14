cmake_minimum_required(VERSION 3.5)
project(md407-project 
	LANGUAGES
        C
        CXX
        ASM
)  

# Setup
set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY")
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_SYSTEM_PROCESSOR arm)

if (WIN32)
	set(CMAKE_SYSTEM_NAME Generic)
endif()

# Set Compiler
set(CMAKE_C_COMPILER arm-none-eabi-gcc)

# Set Directories
set(INCLUDE_DIR include)
set(BUILD_DIR build)  

# Outputs
set(OUTPUT_ELF output.elf)
set(OUTPUT_S19 output.s19)

# Includes
file(GLOB_RECURSE INCLUDES "${INCLUDE_DIR}/**/*.h")

# Compiler flags
set(CMAKE_C_FLAGS "-mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -lgcc -lc_nano -Tmd407-ram.x ${EXTRA_COMPILER_OPTIONS} -nostartfiles")

# Build executable
add_executable(${OUTPUT_ELF} 
	# Local
	src/main.c 

	# Library (add more if needed)
	drivers/perip/stm32f4xx_rcc.c
	drivers/perip/stm32f4xx_gpio.c
	# drivers/perip/misc.c
	# drivers/perip/stm32f4xx_can.c
	# drivers/perip/stm32f4xx_crc.c
	# drivers/perip/stm32f4xx_adc.c
	# drivers/perip/stm32f4xx_cec.c
	# drivers/perip/stm32f4xx_cryp_aes.c
	# drivers/perip/stm32f4xx_cryp.c
	# drivers/perip/stm32f4xx_cryp_des.c
	# drivers/perip/stm32f4xx_cryp_tdes.c
	# drivers/perip/stm32f4xx_dac.c
	# drivers/perip/stm32f4xx_dbgmcu.c
	# drivers/perip/stm32f4xx_dcmi.c
	# drivers/perip/stm32f4xx_dfsdm.c
	# drivers/perip/stm32f4xx_dma2d.c
	# drivers/perip/stm32f4xx_dma.c
	# drivers/perip/stm32f4xx_dsi.c
	# drivers/perip/stm32f4xx_exti.c
	# drivers/perip/stm32f4xx_flash.c
	# drivers/perip/stm32f4xx_flash_ramfunc.c
	# drivers/perip/stm32f4xx_fmpi2c.c
	# drivers/perip/stm32f4xx_fsmc.c
	# drivers/perip/stm32f4xx_hash.c
	# drivers/perip/stm32f4xx_hash_md5.c
	# drivers/perip/stm32f4xx_hash_sha1.c
	# drivers/perip/stm32f4xx_i2c.c
	# drivers/perip/stm32f4xx_iwdg.c
	# drivers/perip/stm32f4xx_lptim.c
	# drivers/perip/stm32f4xx_ltdc.c
	# drivers/perip/stm32f4xx_pwr.c
	# drivers/perip/stm32f4xx_qspi.c
	# drivers/perip/stm32f4xx_rng.c
	# drivers/perip/stm32f4xx_rtc.c
	# drivers/perip/stm32f4xx_sai.c
	# drivers/perip/stm32f4xx_sdio.c
	# drivers/perip/stm32f4xx_spdifrx.c
	# drivers/perip/stm32f4xx_spi.c
	# drivers/perip/stm32f4xx_syscfg.c
	# drivers/perip/stm32f4xx_tim.c
	# drivers/perip/stm32f4xx_usart.c
	# drivers/perip/stm32f4xx_wwdg.c
	# drivers/perip/stm32f4xx_fmc.c 
)

# Link libraries and flags
target_link_libraries(${OUTPUT_ELF} m)
target_link_options(${OUTPUT_ELF} PRIVATE "-L." "-Ldrivers/perip")

# Add include directories
include_directories(${INCLUDE_DIR})
include_directories(${INCLUDE_DIR}/perip)
include_directories(${INCLUDE_DIR}/cmsis)

# Custom target for converting .elf to .s19
add_custom_command(
	OUTPUT ${OUTPUT_S19}
	COMMAND arm-none-eabi-objcopy -S -O srec ${OUTPUT_ELF} ${OUTPUT_S19}
	DEPENDS ${OUTPUT_ELF}
)

add_custom_target(s19 ALL DEPENDS ${OUTPUT_S19})

# Custom target for uploading
add_custom_target(upload COMMAND python upload.py ${OUTPUT_S19} /dev/ttyUSB0)

