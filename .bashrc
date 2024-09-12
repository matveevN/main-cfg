# Sample .bashrc for SUSE Linux
# Copyright (c) SUSE Software Solutions Germany GmbH

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.
#


if [ -z "$DISPLAY" ] && [ "$(tty)" = /dev/tty1 ]; then
    startx
fi

# Цвета для терминала
RESET='\[\033[0m\]'
GREEN='\[\033[0;32m\]'
BLUE='\[\033[0;34m\]'
YELLOW='\[\033[0;33m\]'

# Функция для отображения имени текущей ветки Git
parse_git_branch() {
    git rev-parse --is-inside-work-tree &> /dev/null
    if [ $? -eq 0 ]; then
        branch=$(git symbolic-ref --short HEAD 2> /dev/null)
        echo " ($branch)"
    fi
}

# Настройка PS1 для отображения ветки Git с цветами
PS1="${GREEN}\u@\h:${BLUE}\w${YELLOW}\$(parse_git_branch)${RESET}\$ "

eval "$(fzf --bash)"

