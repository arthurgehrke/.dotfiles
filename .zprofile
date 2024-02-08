# Set PATH, MANPATH, etc., for Homebrew.
export PATH="$HOME/.local/bin:$PATH"

if [ -d "$HOME/.local/lib" ]; then
  export PATH=$HOME/.local/lib:$PATH
fi
