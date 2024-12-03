#!/bin/bash

set -e  # Detener la ejecución si ocurre un error

# Eliminar ngrok existente si está instalado
echo "Removing existing ngrok installation (if any)..."
rm -f "$HOME/.local/bin/ngrok"
rm -rf "$HOME/.local/share/ngrok"

# Crear directorios necesarios
echo "Setting up directories..."
mkdir -p "$HOME/.local/bin"
mkdir -p "$HOME/.local/share/ngrok"

# Copiar archivos necesarios
echo "Copying files..."
cp get-ngrok.sh "$HOME/.local/share/ngrok/"
mv ngrok "$HOME/.local/bin/"  # Mover binario a un directorio en PATH

# Asignar permisos de ejecución al binario
chmod +x "$HOME/.local/bin/ngrok"

# Asegurar que $HOME/.local/bin esté en el PATH
if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
    export PATH="$HOME/.local/bin:$PATH"
fi

# Actualizar y limpiar paquetes
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y proot wget
sudo apt clean && sudo apt autoremove -y

# Ejecutar el script de instalación de ngrok
echo "Running ngrok installation script..."
cd "$HOME/.local/share/ngrok"
bash get-ngrok.sh

# Mensaje de éxito
echo -e "\e[1;32mNgrok installed successfully!"
echo "Run: ngrok"
echo "To use ngrok."
