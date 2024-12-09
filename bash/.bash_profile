if [ -f ~/.profile ]; then
		. ~/.profile
fi

# If not running interactively, we're done
case $- in
  *i*) ;;
    *) return;;
esac

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi


export TERM="xterm-256color"
export SHELL="/Users/aya/.cargo/bin/nu"
export EDITOR="/Users/local/bin/emacs-nw"


PATH="/opt/local/sbin:$PATH"
PATH="/opt/local/bin:$PATH"
PATH="/opt/homebrew/bin:$PATH"
PATH="/Users/aya/Library/Application Support/Coursier/bin:$PATH"
PATH="'/Users/aya/.qlot/bin:$PATH"
PATH="/Users/aya/.modular/bin:$PATH"
PATH="/Users/aya/.cargo/bin:$PATH"
PATH="/Users/aya/local/bin:$PATH"
export PATH


test -r '/Users/aya/.opam/opam-init/init.sh' && . '/Users/aya/.opam/opam-init/init.sh' > /dev/null 2> /dev/null || true
test -r "/Users/aya/.deno/env" && . "/Users/aya/.deno/env"
test -r "/opt/homebrew/opt/asdf/libexec/asdf.sh" && . "/opt/homebrew/opt/asdf/libexec/asdf.sh"
test -r "/opt/homebrew/opt/asdf/etc/bash_completion.d/asdf.bash" && . "/opt/homebrew/opt/asdf/etc/bash_completion.d/asdf.bash"
test -r "$BASH_IT/bash_it.sh" && . "$BASH_IT"/bash_it.sh
