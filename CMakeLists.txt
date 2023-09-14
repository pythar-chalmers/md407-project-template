cmake_minimum_required(VERSION 3.5)
project(md407-project)  # Replace with your actual project name

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
add_executable(${OUTPUT_ELF} src/main.c drivers/perip/stm32f4xx_rcc.c drivers/perip/stm32f4xx_gpio.c)

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

