#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXP_SCRIPT="${SCRIPT_DIR}/thread_lab_autorun.exp"

if ! command -v expect >/dev/null 2>&1; then
  echo "Error: 'expect' binary not found. Install it (macOS: 'brew install expect')." >&2
  exit 1
fi

CONTAINER_NAME="${CONTAINER_NAME:-codelab_otsim_ctnr}"
IMAGE_NAME="${IMAGE_NAME:-openthread/environment:latest}"

echo "Running Thread lab autorun..."
echo "Container: ${CONTAINER_NAME}"
echo "Image: ${IMAGE_NAME}"

echo "Checking Docker daemon health..."
if ! docker version >/dev/null 2>&1; then
  echo "Docker daemon is not healthy (cannot reach API)." >&2
  echo "docker version output:" >&2
  docker version 2>&1 || true
  echo "Disk space (df -h):" >&2
  df -h || true
  exit 1
fi

expect -f "${EXP_SCRIPT}" -- "${CONTAINER_NAME}" "${IMAGE_NAME}"

echo "Thread lab autorun finished."

