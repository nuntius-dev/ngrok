#!/bin/bash

echo "Downloading ngrok..."

# Determinar la arquitectura
architectureURL=$(dpkg --print-architecture)
case "$architectureURL" in
    aarch64|arm64) architectureURL="arm64" ;;
    arm|armhf)     architectureURL="arm" ;;
    amd64|x86_64)  architectureURL="amd64" ;;
    i*86)          architectureURL="386" ;;
    *)
        echo "Error: unsupported architecture ($architectureURL)"
        exit 1
        ;;
esac

# Descargar y descomprimir ngrok
url="https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-${architectureURL}.zip"
wget "$url" -O ngrok.zip && unzip ngrok.zip && rm ngrok.zip

echo "ngrok downloaded and extracted successfully."
