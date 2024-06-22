FILE_ASM = boot
FILE_CPP = start

SRC_ASM = $(foreach buffer, $(FILE_ASM), src/asm/$(buffer).asm)
SRC_CPP = $(foreach buffer, $(FILE_CPP), src/cpp/$(buffer).cpp)

OBJ_ASM = $(foreach buffer, $(FILE_ASM), obj/asm/$(buffer).o)
OBJ_CPP = $(foreach buffer, $(FILE_CPP), obj/cpp/$(buffer).o)

NAME = UwU_Kernel

all: $(NAME)

CXXFLAGS = -m32 -fno-builtin -fno-exception -fno-stack-protector -fno-rtti -nostdlib -nodefaultlibs

$(NAME): $(OBJ_ASM) $(OBJ_CPP)
	ld -m elf_i386 -T linker.ld -o kernel $(OBJ_ASM) $(OBJ_CPP)

clean:
	rm -rf $(OBJ_ASM) $(OBJ_CPP) $(NAME)

re: clean all

obj/asm/%.o: src/asm/%.asm
	mkdir -p $(dir $@)
	nasm -f elf32 $< -o $@

obj/cpp/%.o: src/cpp/%.cpp
	mkdir -p $(dir $@)
	g++ $(CXXFLAGS) -Ihdr -c $< -o $@
