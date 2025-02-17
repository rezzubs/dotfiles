bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'
# shift-tab
bind '"\e[Z":menu-complete-backward'
if command -v fzf > /dev/null; then
  eval "$(fzf --bash)"
fi
