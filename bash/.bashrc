export BASH_IT='/Users/aya/.bash_it'
export BASH_IT_THEME='bobby'
export THEME_CHECK_SUDO='true'
unset MAILCHECK
export SCM_CHECK=true
export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1
# export GIT_HOSTING='git@git.domain.com'
# export IRC_CLIENT='irssi'
# Set this to the location of your work or project folders
# BASH_IT_PROJECT_PATHS="${HOME}/Projects:/Volumes/work/src"
export BASH_IT_THEME='powerline-multiline'
export XDG_CONFIG_HOME='/Users/aya/.config'


alias em='/Users/aya/local/bin/emacs-nw'
alias vimrc='em /Users/aya/.config/nvim/init.vim'
alias bashrc='em -- /Users/aya/.bashrc'
alias bprof='em -- /Users/aya/.bash_profile'
alias sb='. /Users/aya/.bashrc'
alias bn='bash --norc'
alias zconf='em /Users/aya/.config/zellij/config.kdl'
alias zlay='em /Users/aya/.config/zellij/layouts/default.kdl'
alias wconf='em /Users/aya/.config/wezterm/wezterm.lua'
alias econf='em /Users/aya/.config/emacs/init.el'
alias nuconf='em /Users/aya/.config/nushell/config.nu'
alias nuenv='em /Users/aya/.config/nushell/env.nu'
alias kconf='em /Users/aya/.config/kitty/kitty.conf'

# bash specific
test -r '/Users/aya/.fzf.bash' && . '/Users/aya/.fzf.bash'
test -r "/opt/homebrew/opt/asdf/etc/bash_completion.d/asdf.bash" && . "/opt/homebrew/opt/asdf/etc/bash_completion.d/asdf.bash"
test -r "$BASH_IT/bash_it.sh" && . "$BASH_IT"/bash_it.sh