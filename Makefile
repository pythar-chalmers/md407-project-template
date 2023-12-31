# Include the Makefile.project to get the sources
include Makefile.project

# Compiler & commands
CC 				= arm-none-eabi-gcc
LD 				= arm-none-eabi-ld
OBJCOPY 		= arm-none-eabi-objcopy
UPLOAD 			= python upload.py
GDB			 	= arm-none-eabi-gdb

# Directories
INCLUDE_DIR 	= include

# Special headers
STARTUP_INC 	= include/src/startup.h

# Build destination directory
BUILD_DIR 		= build

# Includes
INCLUDES 		= $(wildcard $(INCLUDE_DIR)/**/*.h)
INCLUDE_DIRS 	= $(wildcard $(INCLUDE_DIR)/*)
INCLUDE_FLAGS 	= $(foreach dir,$(INCLUDE_DIRS),-I$(dir))

# Compiler & linker flags
# Compiler flags
CC_FLAGS =   -mcpu=cortex-m4 -mfpu=fpv4-sp-d16 -lgcc -lc_nano -Tmd407-ram.x 
CC_FLAGS +=  $(EXTRA_COMPILER_OPTIONS)
CC_FLAGS +=  -specs=nano.specs -specs=nosys.specs 
CC_FLAGS +=  -nostartfiles 
CC_FLAGS +=  -L. 
CC_FLAGS +=  -L drivers/perip  
CC_FLAGS +=  -L /usr/include/newlib/c++/9.2.1/arm-none-eabi/thumb/v6-m/nofp 
CC_FLAGS +=  -L /usr/lib/arm-none-eabi/newlib/thumb/v6-m/nofp 
CC_FLAGS +=  -L /usr/lib/gcc/arm-none-eabi/9.2.1/thumb/v6-m/nofp 
CC_FLAGS +=  $(INCLUDE_FLAGS)

# Object files
OBJS 		= $(patsubst %.c,$(BUILD_DIR)/%.o,$(SOURCES))

# Output files
OUTPUT_BIN 		= $(BUILD_DIR)/output.elf
OUTPUT_S19 		= $(BUILD_DIR)/output.s19

# Build rules
all: $(OUTPUT_S19)

$(OUTPUT_S19): $(OUTPUT_BIN)
	$(OBJCOPY) -S -O srec $< $@ 

$(OUTPUT_BIN): $(SOURCES) $(INCLUDES) $(STARTUP_INC)
	mkdir -p $(dir $@)
	$(CC) $(CC_FLAGS) $(SOURCES) -o $@

upload: $(OUTPUT_S19)
	$(UPLOAD) $(DEV_PORT) $(OUTPUT_S19)

s19: $(OUTPUT_S19) 

elf: $(OUTPUT_BIN)

gdb: $(OUTPUT_BIN)
	$(GDB)

clean:
	rm -rf $(BUILD_DIR)

# Include dependencies (generated by GCC)
-include $(MAIN_OBJS:.o=.d)
-include $(DRIVER_OBJS:.o=.d)

.PHONY: all clean upload s19 elf
