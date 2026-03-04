#!/bin/bash
set -euo pipefail

SWAP_SIZE="2G"
SWAP_FILE="/swapfile"

if [ -f "$SWAP_FILE" ]; then
  echo "Swap file already exists, skipping."
  exit 0
fi

echo "Creating ${SWAP_SIZE} swap file..."
fallocate -l "$SWAP_SIZE" "$SWAP_FILE"
chmod 600 "$SWAP_FILE"
mkswap "$SWAP_FILE"
swapon "$SWAP_FILE"

echo "${SWAP_FILE} none swap sw 0 0" >> /etc/fstab

echo "Swap enabled:"
swapon --show
