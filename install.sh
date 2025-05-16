#!/bin/bash

# Установка пакетов из pkglist.txt
sudo pacman -Syu --needed - < pkglist.txt

# Копирование конфигов
cp -r config/* ~/.config/
cp home/.* ~/

# Установка шрифов
cp -r local/.fonts ~/
fc-cache -fv

# Установка Zsh и Oh My Zsh (если нужно)
if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git
    cd yay && makepkg -si --noconfirm
fi
yay -S --needed - < aur-pkglist.txt

# Даем права на скрипты
chmod +x ~/.local/bin/*

echo "Установка завершена! Перезагрузите систему."
