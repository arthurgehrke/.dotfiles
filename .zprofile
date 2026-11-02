# The following lines were added by Docker Desktop to add commands to your PATH.
export PATH="$PATH:/Users/arthurgehrke/.docker/bin"
# End of Docker Desktop section.

export PATH="$PATH:/Users/arthurgehrke/.docker/bin"

eval $(/opt/homebrew/bin/brew shellenv)

if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi
