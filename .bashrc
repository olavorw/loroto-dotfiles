#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
alias dots='git --git-dir=/home/olavorw/.dotfiles/ --work-tree /home/olavorw'
fastfetch
eval "$(oh-my-posh init bash --config 'tokyonight_storm')"
