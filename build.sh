#!/bin/bash
# build.sh

set -e

echo "==== Сборка scrcpy для Linux ===="

# Очистка предыдущей сборки
rm -rf build

# Скачивание обновлений репозитория https://github.com/UnderMind0x41/scrcpy
# git clone https://github.com/UnderMind0x41/scrcpy.git

# Скачивание обновлений репозитория
git fetch
git checkout
git pull

# Скачивание сервера
if [ ! -f "scrcpy-server" ]; then
    echo "Скачивание scrcpy-server..."
    wget https://github.com/Genymobile/scrcpy/releases/download/v3.2/scrcpy-server-v3.2 -O scrcpy-server
fi

# Настройка и сборка
echo "Настройка сборки..."
meson setup build --buildtype=release --strip -Db_lto=true -Dprebuilt_server=./scrcpy-server

echo "Компиляция..."
ninja -C build

echo "Готово! Исполняемый файл: build/app/scrcpy"

# Копируем исполняемый файл в /usr/bin/
sudo cp build/app/scrcpy /usr/bin/
echo "Исполняемый файл скопирован в /usr/bin/scrcpy"

# Копируем сервер в /usr/bin/
sudo cp scrcpy-server /usr/bin/
echo "Сервер скопирован в /usr/bin/scrcpy-server"

