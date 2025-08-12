NAME = asm
LIBNAME = libasm.a
BONUS_NAME = asm_bonus
BONUS_LIBNAME = bonus_libasm.a

# Couleurs pour l'affichage
LCYAN = \033[1;36m
GREEN = \033[0;32m
LGREEN = \033[1;32m
LRED = \033[1;31m
RESET = \033[0m
GRAY = \033[90m
PURPLE = \033[0;35m
YELLOW = \033[1;33m

INFO = $(LCYAN)/INFO/$(RESET)
CLEANING = $(LRED)[DELETING]$(RESET)
SUCCESS = $(LGREEN)[SUCCESS]$(RESET)
BONUS_INFO = $(YELLOW)/BONUS/$(RESET)

# Outils
ASM = nasm
CC = cc
AR = ar

# Flags
ASMFLAGS = -felf64 -g
CFLAGS = -Wall -Wextra -Werror -g
ARFLAGS = rcs

# Répertoires
OBJ_DIR = obj
SRC_DIR = .

# Fichiers sources
LIB_FILES = ft_strlen ft_strcpy ft_write ft_strcmp ft_read ft_strdup
BONUS_FILES = bonus/ft_atoi_base bonus/ft_list_push_front bonus/ft_list_size
C_MAIN_FILES = main
C_BONUS_MAIN_FILES = main_bonus

# Objects
LIB_OBJS = $(addprefix $(OBJ_DIR)/, $(addsuffix .o, $(LIB_FILES)))
BONUS_OBJS = $(addprefix $(OBJ_DIR)/, $(addsuffix .o, $(BONUS_FILES)))
C_MAIN_OBJS = $(addprefix $(OBJ_DIR)/, $(addsuffix .o, $(C_MAIN_FILES)))
C_BONUS_MAIN_OBJS = $(addprefix $(OBJ_DIR)/, $(addsuffix .o, $(C_BONUS_MAIN_FILES)))

# Règles principales
all: $(NAME)

bonus: $(BONUS_NAME)

# Compilation des fichiers assembleur
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s
	@mkdir -p $(dir $@)
	@echo "$(INFO) $(PURPLE)Assembling $<$(RESET)"
	@$(ASM) $(ASMFLAGS) $< -o $@

# Compilation des fichiers C
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(dir $@)
	@echo "$(INFO) $(GREEN)Compiling $<$(RESET)"
	@$(CC) $(CFLAGS) -c $< -o $@

# Création de la bibliothèque principale
$(LIBNAME): $(LIB_OBJS)
	@echo "$(INFO) $(GREEN)Creating library $(LIBNAME)$(RESET)"
	@$(AR) $(ARFLAGS) $(LIBNAME) $(LIB_OBJS)

# Création de la bibliothèque bonus (inclut les fonctions de base + bonus)
$(BONUS_LIBNAME): $(LIB_OBJS) $(BONUS_OBJS)
	@echo "$(BONUS_INFO) $(GREEN)Creating bonus library $(BONUS_LIBNAME)$(RESET)"
	@$(AR) $(ARFLAGS) $(BONUS_LIBNAME) $(LIB_OBJS) $(BONUS_OBJS)

# Exécutable principal
$(NAME): $(LIBNAME) $(C_MAIN_OBJS)
	@echo "$(INFO) $(GREEN)Linking $(NAME)$(RESET)"
	@$(CC) -o $(NAME) $(C_MAIN_OBJS) -L. -lasm
	@echo "$(SUCCESS) $(NAME) created!"

# Exécutable bonus
$(BONUS_NAME): $(BONUS_LIBNAME) $(C_BONUS_MAIN_OBJS)
	@echo "$(BONUS_INFO) $(GREEN)Linking $(BONUS_NAME)$(RESET)"
	@$(CC) -o $(BONUS_NAME) $(C_BONUS_MAIN_OBJS) -L. -l:bonus_libasm.a
	@echo "$(SUCCESS) $(BONUS_NAME) created!"

# Nettoyage
clean:
	@echo "$(CLEANING) $(GRAY)$(OBJ_DIR) directory$(RESET)"
	@rm -rf $(OBJ_DIR)

fclean: clean
	@echo "$(CLEANING) $(GRAY)$(NAME) executable$(RESET)"
	@echo "$(CLEANING) $(GRAY)$(LIBNAME) library$(RESET)"
	@echo "$(CLEANING) $(GRAY)$(BONUS_NAME) executable$(RESET)"
	@echo "$(CLEANING) $(GRAY)$(BONUS_LIBNAME) library$(RESET)"
	@rm -f $(NAME) $(LIBNAME) $(BONUS_NAME) $(BONUS_LIBNAME)

re: fclean all

re_bonus: fclean bonus

.PHONY: all bonus clean fclean re re_bonus