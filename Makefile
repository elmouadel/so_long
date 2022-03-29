# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: eabdelha <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/12/27 10:10:17 by eabdelha          #+#    #+#              #
#    Updated: 2022/03/29 11:02:29 by eabdelha         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = so_long
NAME_LIBFT = libft.a
MLX = -L /usr/local/lib/ -lmlx -framework OpenGL -framework AppKit

MLX_INCLUDE = /usr/local/include
INCLUDE = ./src_man/so_long.h
BINCLUDE = ./src_bonus/so_long_bonus.h

FOBJ_SRC = object_files_bonus
OBJECT_PATH = ./object_files_bonus/

LIBFT_PATH = ./libft
SRC_PATH = ./src_man
BSRC_PATH = ./src_bonus

CC = gcc
CFLAGS = -Wall -Wextra -Werror

BSRC =  so_long_bonus.c     \
		so_long_utils_bonus.c      \
		read_map_bonus.c	\
		display_bonus.c	\
		enemy_move_bonus.c

SRC =  	so_long.c         \
        so_long_utils.c		\
		read_map.c \
		display.c

.PHONY : all bonus clean fclean re

M_OBJECTS =  $(addprefix $(OBJECT_PATH), $(SRC:.c=.o))
B_OBJECTS =  $(addprefix $(OBJECT_PATH), $(BSRC:.c=.o))

all: $(NAME)

bonus : $(FOBJ_SRC) $(B_OBJECTS) $(BINCLUDE) $(MLX_INCLUDE)
	@make -C $(LIBFT_PATH)
	@printf "linking object files...\n"
	@$(CC) $(CFLAGS) $(B_OBJECTS) $(LIBFT_PATH)/$(NAME_LIBFT) $(MLX) -o $(BSRC_PATH)/$(NAME)

$(NAME): $(FOBJ_SRC) $(M_OBJECTS) $(INCLUDE) $(MLX_INCLUDE)
	@make -C $(LIBFT_PATH)
	@printf "linking object files...\n"
	@$(CC) $(CFLAGS) $(M_OBJECTS) $(LIBFT_PATH)/$(NAME_LIBFT) $(MLX) -o $(SRC_PATH)/$(NAME)

$(OBJECT_PATH)%.o: $(BSRC_PATH)/%.c $(INCLUDE)
	$(CC) $(CFLAGS) -o $@ -c $<

$(OBJECT_PATH)%.o: $(SRC_PATH)/%.c $(INCLUDE)
	$(CC) $(CFLAGS) -o $@ -c $<

$(FOBJ_SRC) : 
	@mkdir $@

clean:
	@make clean -C $(LIBFT_PATH)
	@rm -f $(OBJECTS)
	@rm -rf $(FOBJ_SRC)

fclean: clean
	@make fclean -C $(LIBFT_PATH) 
	@rm -rf $(BSRC_PATH)/$(NAME) $(SRC_PATH)/$(NAME)

re: fclean all

