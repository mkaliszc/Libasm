NAME = asm
LIBNAME = libasm.a

# Couleurs pour l'affichage
LCYAN = \033[1;36m
GREEN = \033[0;32m
LGREEN = \033[1;32m
LRED = \033[1;31m
RESET = \033[0m
GRAY = \033[90m
PURPLE = \033[0;35m

INFO = $(LCYAN)/INFO/$(RESET)
CLEANING = $(LRED)[DELETING]$(RESET)
SUCCESS = $(LGREEN)[SUCCESS]$(RESET)

# Outils
ASM = nasm
CC = gcc
AR = ar

# Flags
ASMFLAGS = -f elf64 -g
CFLAGS = -Wall -Wextra -Werror -g
ARFLAGS = rcs

# Répertoires
OBJ_DIR = obj
SRC_DIR = .

# Fichiers sources
LIB_FILES = ft_strlen ft_strcpy ft_write
C_MAIN_FILES = main

# Objects
LIB_OBJS = $(addprefix $(OBJ_DIR)/, $(addsuffix .o, $(LIB_FILES)))
C_MAIN_OBJS = $(addprefix $(OBJ_DIR)/, $(addsuffix .o, $(C_MAIN_FILES)))

all: $(NAME)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s
	@mkdir -p $(dir $@)
	@echo "$(INFO) $(PURPLE)Assembling $<$(RESET)"
	@$(ASM) $(ASMFLAGS) $< -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(dir $@)
	@echo "$(INFO) $(GREEN)Compiling $<$(RESET)"
	@$(CC) $(CFLAGS) -c $< -o $@

$(LIBNAME): $(LIB_OBJS)
	@echo "$(INFO) $(GREEN)Creating library $(LIBNAME)$(RESET)"
	@$(AR) $(ARFLAGS) $(LIBNAME) $(LIB_OBJS)

$(NAME): $(LIBNAME) $(C_MAIN_OBJS)
	@echo "$(INFO) $(GREEN)Linking $(NAME)$(RESET)"
	@$(CC) -o $(NAME) $(C_MAIN_OBJS) -L. -lasm
	@echo "$(SUCCESS) $(NAME) created!"

clean:
	@echo "$(CLEANING) $(GRAY)$(OBJ_DIR) directory$(RESET)"
	@rm -rf $(OBJ_DIR)

fclean: clean
	@echo "$(CLEANING) $(GRAY)$(NAME) executable$(RESET)"
	@echo "$(CLEANING) $(GRAY)$(LIBNAME) library$(RESET)"
	@rm -f $(NAME) $(LIBNAME)

re: fclean all

.PHONY: all clean fclean re