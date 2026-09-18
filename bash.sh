#!/data/data/com.termux/files/usr/bin/bash

set -e

BASE_URL="https://raw.githubusercontent.com/USERNAME/REPO/main"

echo "[+] Installing dependencies..."

pkg update -y
pkg upgrade -y
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

python -m pip install gmalg pycryptodome zstandard

echo "[+] Installing Node packages..."

npm install -g luamin luaparse

echo "[+] Downloading SKUYV5..."

rm -rf "$HOME/SKUYV5" "$HOME/SKUYV5.zip"

curl -fL --retry 3 \
    -o "$HOME/SKUYV5.zip" \
    "$BASE_URL/SKUYV5.zip"

echo "[+] Extracting..."

mkdir -p "$HOME/SKUYV5"

unzip -o \
    "$HOME/SKUYV5.zip" \
    -d "$HOME/SKUYV5"

cd "$HOME/SKUYV5"

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
