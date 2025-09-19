#------------------------------------------------------------------------------#
#   NAME                                                                       #
#------------------------------------------------------------------------------#
NAME		:= libasm.a

#------------------------------------------------------------------------------#
#   INGREDIENTS                                                                #
#------------------------------------------------------------------------------#
SRCS_DIR	:= srcs
SRCS		:= \
				ft_strlen.s
SRCS		:= $(SRCS:%=$(SRCS_DIR)/%)

BUILD_DIR	:= .build
OBJS		:= $(SRCS:$(SRCS_DIR)/%.s=$(BUILD_DIR)/%.o)
DEPS		:= $(OBJS:.o=.d)

AS			:= nasm
ASFLAGS		:= -f elf64

LD			:= ld
LDFLAGS		:= -m elf_x86_64

#------------------------------------------------------------------------------#
#   UTENSILS                                                                   #
#------------------------------------------------------------------------------#
RM			+= -r
MAKE		:= $(MAKE) --jobs --silent --no-print-directory
DIR_DUP		= mkdir -p $(@D)
VALGRIND	:= valgrind -q -s --leak-check=yes --show-leak-kinds=all \
				--track-fds=yes --track-origins=yes --trace-children=yes \
				--verbose
ERR_MUTE	:= 2>/dev/null

CRUSH		:= \r\033[K
ECHO		:= echo -n "$(CRUSH)"
R			:= $(shell tput setaf 1)
G			:= $(shell tput setaf 2)
END			:= $(shell tput sgr0)

#------------------------------------------------------------------------------#
#   RECIPES                                                                    #
#------------------------------------------------------------------------------#
all: $(NAME)

$(NAME): $(OBJS)
	$(AS) $(OBJS) -o $(NAME)
	$(ECHO)"$(G)CREATED$(END) $(@)\n"

$(BUILD_DIR)/%.o: $(SRCS_DIR)/%.s
	$(DIR_DUP)
	$(AS) $(ASFLAGS) $< -o $@.o
	$(LD) $(LDFLAGS) $@.o -o $@
	$(ECHO)"$(G)CREATED$(END) $(@)\n"

-include $(DEPS)

clean:
	$(RM) $(BUILD_DIR)
	$(ECHO)"$(R)DELETED $(BUILD_DIR)$(END)\n"

fclean: clean
	$(RM) $(NAME)
	$(ECHO)"$(R)DELETED $(NAME)$(END)\n"

re:
	$(MAKE) fclean
	$(MAKE) all

run-%: $(NAME)
	-./$(NAME) $*


vrun-%: CFLAGS += -g3
vrun-%: $(NAME)
	-$(VALGRIND) ./$(NAME) $*

info-%:
	$(MAKE) --dry-run --always-make $* | grep -v "info"

print-%:
	$(info $*='$($*)')

#------------------------------------------------------------------------------#
#   SPEC                                                                       #
#------------------------------------------------------------------------------#
.PHONY: clean fclean re
.SILENT:
