#!/usr/bin/env bash

set -eo pipefail

echo "- Launching dumprx"

ROMPATH=""
cd "${ROMPATH}"
if [[ -n "${OTA_ZIP_URL}" ]]
then
    ROMPATH="${OTA_ZIP_URL}"
elif [[ -f "${OTA_ZIP_PATH}" ]]
then
    ROMPATH="$(realpath "${OTA_ZIP_PATH}")"
fi

if [[ -z "${ROMPATH}" ]]
then
    echo "You must specify either OTA_ZIP_URL or OTA_ZIP_PATH ! "
    exit 1
fi

export PATH="${PATH}:${HOME}/.local/bin" # Add extract-dtb in path
bash "dumper.sh" "${ROMPATH}" || true

echo "Copying out"
sudo cp -r "${HOME}/out/"* "/dump"
