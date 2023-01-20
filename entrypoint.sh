#!/usr/bin/env bash

set -eo pipefail

echo "- Launching dumpyara"

ROMPATH="${HOME}"
cd "${ROMPATH}"
if [[ -n "${OTA_ZIP_URL}" ]]
then
    ROMPATH="$(realpath "$(basename "${OTA_ZIP_URL}")")"
    curl -L --progress-bar -o "${ROMPATH}" "${OTA_ZIP_URL}"
elif [[ -f "${OTA_ZIP_PATH}" ]]
then
    ROMPATH="$(realpath "${OTA_ZIP_PATH}")"
fi

if [[ ! -f "${ROMPATH}" ]]
then
    echo "You must specify either OTA_ZIP_URL or OTA_ZIP_PATH ! "
    exit 1
fi

export PATH="${PATH}:${HOME}/.local/bin" # Add extract-dtb in path
python3 -m dumpyara -o "${HOME}/working" -v "${ROMPATH}"

sudo cp -vr "${HOME}/working/"* "/dump"
