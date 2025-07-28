NAME = asm

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

# Outils assembleur
ASM = nasm
LD = ld

# Flags
ASMFLAGS = -f elf64 -g
LDFLAGS = -m elf_x86_64

# Répertoires
OBJ_DIR = obj
SRC_DIR = .

# Fichiers sources assembleur
ASM_FILES = main ft_strlen ft_strcpy ft_write
ASM_SRC = $(addsuffix .s, $(ASM_FILES))
ASM_OBJS = $(addprefix $(OBJ_DIR)/, $(addsuffix .o, $(ASM_FILES)))

all: $(NAME)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s
	@mkdir -p $(dir $@)
	@echo "$(INFO) $(PURPLE)Assembling $<$(RESET)"
	@$(ASM) $(ASMFLAGS) $< -o $@

$(NAME): $(ASM_OBJS)
	@echo "$(INFO) $(GREEN)Linking $(NAME)$(RESET)"
	@$(LD) $(LDFLAGS) -o $(NAME) $(ASM_OBJS)
	@echo "$(SUCCESS) $(NAME) created!"

clean:
	@echo "$(CLEANING) $(GRAY)$(OBJ_DIR) directory$(RESET)"
	@rm -rf $(OBJ_DIR)

fclean: clean
	@echo "$(CLEANING) $(GRAY)$(NAME) executable$(RESET)"
	@rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re