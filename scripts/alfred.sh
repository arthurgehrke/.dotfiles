#!/bin/bash

ALFRED_SRC="$HOME/Library/Application Support/Alfred/Alfred.alfredpreferences"
DOTFILES_DIR="$HOME"
ALFRED_DST="$DOTFILES_DIR/Alfred.alfredpreferences"

backup() {
  echo "Fazendo backup da configuração do Alfred..."

  mkdir -p "$DOTFILES_DIR"

  if [ -d "$ALFRED_SRC" ]; then
    mv "$ALFRED_SRC" "$ALFRED_DST"
    echo "Backup concluído: $ALFRED_DST"
  else
    echo "Erro: Configuração do Alfred não encontrada!"
    exit 1
  fi

  ln -s "$ALFRED_DST" "$ALFRED_SRC"
  echo "Symlink criado: $ALFRED_SRC -> $ALFRED_DST"
}

restore() {
  echo "Restaurando configuração do Alfred..."

  if [ -d "$ALFRED_DST" ]; then
    rm -rf "$ALFRED_SRC"

    ln -s "$ALFRED_DST" "$ALFRED_SRC"
    echo "Restaurado: $ALFRED_SRC -> $ALFRED_DST"
  else
    echo "Erro: Backup do Alfred não encontrado em $ALFRED_DST"
    exit 1
  fi
}

case "$1" in
backup)
  backup
  ;;
restore)
  restore
  ;;
*)
  echo "Uso: $0 {backup|restore}"
  exit 1
  ;;
esac
