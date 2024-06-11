if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
  exec hypr-run
fi
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
