#!/data/data/com.termux/files/usr/bin/bash

set -e

BASE_URL="https://raw.githubusercontent.com/iMagee0x1/SKUYV5/main"
INSTALL_DIR="$HOME/SKUYV5"
ZIP_FILE="$HOME/SKUYV5.zip"

echo "[+] Updating package lists..."
pkg update -y

echo "[+] Installing dependencies..."
pkg install -y \
    python \
    python-pip \
    nodejs \
    openjdk-21 \
    unzip \
    zip \
    clang \
    make \
    pkg-config \
    coreutils \
    findutils \
    grep \
    sed \
    curl

echo "[+] Installing Python packages..."
python -m pip install -U \
    gmalg \
    pycryptodome \
    zstandard

echo "[+] Installing Node packages..."
npm install -g luamin luaparse

echo "[+] Downloading SKUYV5..."
rm -rf "$INSTALL_DIR" "$ZIP_FILE"

curl -fL --retry 3 \
    --retry-delay 2 \
    -o "$ZIP_FILE" \
    "$BASE_URL/SKUYV5.zip"

echo "[+] Extracting..."
mkdir -p "$INSTALL_DIR"

unzip -o "$ZIP_FILE" -d "$INSTALL_DIR"

cd "$INSTALL_DIR/SKUYV5"

echo "[+] Setting permissions..."

chmod 755 \
    native_build/skuy \
    native_build/skuy_runtime_stage12.so

chmod 755 \
    EXES/luac \
    EXES/luadec \
    EXES/LUADEC

echo "[+] Starting SKUYV5..."

exec ./native_build/skuy
