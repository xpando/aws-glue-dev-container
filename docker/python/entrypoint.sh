#!/bin/sh

if [ -d "$HOME/bin" ]; then
  export PATH="$HOME/bin:$PATH"
fi

if [ -z "$NO_ACTIVATE_VENV" ] && [ -d "/app/venv" ]; then
  source "/app/venv/bin/activate"
fi

exec "$@"
