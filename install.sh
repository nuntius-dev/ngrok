#!/bin/bash

set -e  # Detener la ejecución si ocurre un error

# Eliminar ngrok existente si está instalado
echo "Removing existing ngrok installation (if any)..."
rm -f "$PREFIX/bin/ngrok"
rm -rf "$PREFIX/share/ngrok"

# Crear directorios necesarios
echo "Setting up directories..."
mkdir -p "$PREFIX/share/ngrok"

# Copiar archivos necesarios
echo "Copying files..."
cp get-ngrok.sh "$PREFIX/share/ngrok/"
cp ngrok "$PREFIX/bin/"

# Actualizar y limpiar paquetes
echo "Updating system packages..."
apt update && apt upgrade -y
apt install -y proot wget resolv-conf
apt clean && apt autoremove -y

# Ejecutar el script de instalación de ngrok
echo "Running ngrok installation script..."
cd "$PREFIX/share/ngrok"
bash get-ngrok.sh

# Mensaje de éxito
echo -e "\e[1;32mNgrok installed successfully!"
echo "Run: ngrok"
echo "To use ngrok."
