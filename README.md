MyNixOS

Моя персональная модульная конфигурация NixOS для основного ПК.

Репозиторий построен вокруг Nix Flakes, Home Manager, KDE Plasma 6 и Plasma Manager. Системная и пользовательская конфигурации разделены на небольшие логические модули.

GitHub: https://github.com/12615az-droid/MyNixOS

Основной стек

- NixOS 26.05
- "x86_64-linux"
- Nix Flakes
- Home Manager 26.05
- Plasma Manager
- KDE Plasma 6
- SDDM
- systemd-boot
- NetworkManager
- PipeWire
- NVIDIA proprietary driver
- libvirt + QEMU/KVM

Основная Flake-конфигурация:

nixosConfigurations.nixos

KDE Plasma

Основное рабочее окружение — KDE Plasma 6.

Пользовательская конфигурация Plasma управляется декларативно через Plasma Manager:

home/popov/kde-preset/
├── appearance.nix
├── default.nix
├── file-icons.nix
├── icons/
│   └── text-x-nix.svg
├── lockscreen.nix
├── panel.nix
├── power.nix
├── shortcuts.nix
└── theme.nix

Внешний вид

Используется светлый Breeze:

- Breeze Look and Feel
- Breeze Light
- Breeze Icons
- обои "Scarlet Tree"
- насыщенный фиолетовый accent "#6D28D9"

Панель

Нижняя панель Plasma настроена как единая панель:

- расположение снизу;
- на всю ширину экрана;
- без floating-отступа;
- автоматическое скрытие;
- появляется при наведении на нижний край;
- Kickoff;
- закреплённые приложения;
- системный трей;
- часы.

Среди закреплённых приложений:

- Dolphin
- Konsole
- Firefox
- VS Code
- Discord
- Steam
- System Settings
- Virt-Manager
- KDE Connect
- Android Studio
- Heroic Games Launcher
- AyuGram

Горячие клавиши

Основные сочетания построены вокруг Meta / Win:

Комбинация| Действие
"Meta"| открыть меню приложений
"Meta + Enter"| открыть Konsole
"Meta + Q"| закрыть активное окно
"Meta + W"| KDE Overview
"Meta + ,"| показать открытые окна

Кастомная иконка ".nix"

Для файлов Nix настроен отдельный MIME-тип:

*.nix
  ↓
text/x-nix
  ↓
text-x-nix

В Breeze используется собственная SVG-иконка: стандартный файл с классическим синим логотипом Nix.

Благодаря этому ".nix"-файлы в Dolphin сразу отличаются от обычных текстовых файлов.

SDDM

Экран входа SDDM вынесен в отдельный системный модуль:

modules/desktop/sddm.nix

SDDM используется вместе с Plasma и оформляется в том же стиле, что и рабочее окружение.

Оборудование

Графика

- Intel UHD 730
- NVIDIA GeForce GTX 1060
- проприетарный драйвер NVIDIA
- NVIDIA modesetting
- 32-битные графические библиотеки для Steam и Proton
- Vulkan

Конфигурация NVIDIA:

hosts/nixos/hardware/nvidia.nix

Мониторы

Пользовательская конфигурация мониторов:

home/popov/monitors.nix

Звук

Используется PipeWire:

- PipeWire
- ALSA
- PulseAudio compatibility
- RTKit
- 32-битная поддержка ALSA
- "pavucontrol"
- "qpwgraph"
- "alsa-utils"

Bluetooth и печать

modules/desktop/bluetooth.nix
modules/desktop/printer.nix

Swap

Настройка находится в:

modules/system/swap.nix

Используются:

- zram;
- "zstd";
- резервный swapfile.

Игры

Игровая конфигурация разделена на системную и пользовательскую части.

Системная часть

modules/programs/gaming.nix

- Steam
- GameMode
- Vulkan Tools
- Mesa Demos

Пользовательская часть

home/popov/gaming.nix
home/popov/mangohud.nix

- Heroic Games Launcher
- Legendary
- ProtonUp-Qt
- Gamescope
- Lutris
- MangoHud

MangoHud

MangoHud настроен в двух вариантах.

Full

mangohud-full

Полный профиль предназначен для подробного мониторинга и диагностики:

- FPS и frametime;
- FPS metrics;
- GPU load, temperature, clocks и power;
- VRAM;
- CPU load, temperature, clocks и power;
- загрузка отдельных ядер;
- RAM и swap;
- память процесса;
- disk I/O;
- Wine;
- GameMode;
- present mode;
- display server;
- resolution;
- дополнительные параметры графического стека.

Lite

mangohud-lite

Компактный профиль для обычной игры:

- FPS;
- frametime;
- GPU load;
- GPU temperature;
- GPU power;
- VRAM;
- CPU load;
- CPU temperature;
- CPU power;
- RAM;
- GameMode;
- present mode.

Виртуализация

modules/virtualization/default.nix

Используются:

- KVM
- QEMU
- libvirt
- Virt-Manager
- Virt-Viewer
- swtpm
- SPICE
- USB redirection

Основное подключение libvirt:

qemu:///system

Каталоги для виртуальных машин и ISO создаются автоматически, включая:

~/VMs
~/VMs/images
/home/popov/Drives/HDD1/VMs
/home/popov/Drives/HDD1/VMs/iso

Разработка

Системные инструменты разработки:

modules/programs/base-dev.nix

Пользовательское окружение:

home/popov/development.nix

Используются:

- GCC
- GNU Make
- CMake
- pkg-config
- GDB
- Python 3
- pip
- virtualenv
- VS Code
- Android Studio
- Android Platform Tools / ADB
- JDK 17
- Kotlin
- Gradle

adb-qr

В:

packages/adb-qr/

находится локальное Nix-описание стороннего проекта "adb-qr" (https://github.com/aleixrodriala/adb-qr).

Сам "adb-qr" не является моим проектом. Локальный derivation нужен для установки программы через эту конфигурацию, поскольку готового пакета для неё нет в используемом Nixpkgs.

"adb-qr" позволяет выполнять wireless ADB pairing Android-устройства через QR-код.

Программы

Среди пользовательских программ:

- Firefox
- Dolphin
- Konsole
- Kate
- Spectacle
- LibreOffice
- VLC
- Strawberry
- Darktable
- Inkscape
- Discord
- AyuGram Desktop
- qBittorrent
- scrcpy
- btop
- htop
- nvtop
- iotop
- nethogs
- bandwhich
- fzf
- duf
- системные и сетевые утилиты

Fastfetch

Fastfetch немного кастомизирован через Home Manager:

home/popov/fastfetch.nix

Используется встроенный логотип NixOS и собственное расположение информации по секциям:

USER
OS
HARDWARE

Вывод включает, среди прочего:

- пользователя;
- ссылку на GitHub;
- ОС;
- kernel;
- uptime;
- количество пакетов;
- desktop/session;
- модель компьютера;
- мониторы;
- CPU;
- GPU;
- RAM;
- диски.

Также настроены свои цвета, разделители и формат вывода.

KDE Connect

KDE Connect включён системно и используется для интеграции Android-устройств с Plasma.

Bash

Настройки Bash находятся в:

home/popov/shell.nix
home/popov/function.nix

Алиасы

Алиас| Команда / действие
"ll"| "ls -lah"
"sbtop"| запустить "btop" через "sudo"
"rebuild"| применить текущий "~/MyNixOS"
"nbuild"| только собрать конфигурацию
"ntest"| временно применить конфигурацию для тестирования
"nupdate"| обновить Flake inputs и выполнить rebuild
"nclean"| удалить старые поколения и мусор Nix
"watchnvidia"| обновлять "nvidia-smi" каждую секунду
"grep"| "grep" с автоматическим цветным выводом

Основные команды:

rebuild
nbuild
ntest
nupdate
nclean
watchnvidia

"rebuildVPN"

Также определена Bash-функция:

rebuildVPN <server> <ip>

Она выполняет удалённый "nixos-rebuild" VPN-сервера из отдельного Flake-конфига через SSH.

Структура репозитория

.
├── configuration.nix
├── flake.lock
├── flake.nix
│
├── home/
│   ├── default.nix
│   └── popov/
│       ├── adGuardVpn.nix
│       ├── baloo.nix
│       ├── btop.nix
│       ├── default.nix
│       ├── development.nix
│       ├── fastfetch.nix
│       ├── function.nix
│       ├── gaming.nix
│       ├── git.nix
│       ├── kde-preset/
│       │   ├── appearance.nix
│       │   ├── default.nix
│       │   ├── file-icons.nix
│       │   ├── icons/
│       │   │   └── text-x-nix.svg
│       │   ├── lockscreen.nix
│       │   ├── panel.nix
│       │   ├── power.nix
│       │   ├── shortcuts.nix
│       │   └── theme.nix
│       ├── mangohud.nix
│       ├── monitors.nix
│       ├── packages.nix
│       └── shell.nix
│
├── hosts/
│   └── nixos/
│       ├── default.nix
│       ├── hardware/
│       │   ├── bootloader.nix
│       │   ├── default.nix
│       │   ├── disks.nix
│       │   └── nvidia.nix
│       └── hardware-configuration.nix
│
├── modules/
│   ├── default.nix
│   ├── desktop/
│   │   ├── audio.nix
│   │   ├── bluetooth.nix
│   │   ├── default.nix
│   │   ├── graphics.nix
│   │   ├── kde.nix
│   │   ├── printer.nix
│   │   └── sddm.nix
│   ├── programs/
│   │   ├── base-dev.nix
│   │   ├── default.nix
│   │   ├── gaming.nix
│   │   ├── obs.nix
│   │   └── packages.nix
│   ├── system/
│   │   ├── boot.nix
│   │   ├── default.nix
│   │   ├── locale.nix
│   │   ├── network.nix
│   │   ├── nix-settings.nix
│   │   ├── ssh.nix
│   │   └── swap.nix
│   ├── users/
│   │   └── default.nix
│   └── virtualization/
│       └── default.nix
│
├── packages/
│   └── adb-qr/
│       └── default.nix
│
└── README.md

Разделение конфигурации

"hosts/"

Настройки конкретной машины:

hosts/nixos/

Здесь находятся конфигурация оборудования, загрузчика, дисков и NVIDIA.

"modules/"

Общие системные NixOS-модули:

modules/
├── desktop/
├── programs/
├── system/
├── users/
└── virtualization/

"home/"

Пользовательская конфигурация Home Manager:

home/popov/

Здесь находятся Plasma Manager, программы, shell, Git, игровое окружение, Fastfetch, MangoHud и настройки разработки.

Сборка и применение

Собрать:

sudo nixos-rebuild build --flake .#nixos

Временно протестировать:

sudo nixos-rebuild test --flake .#nixos

Применить:

sudo nixos-rebuild switch --flake .#nixos

Или через настроенный алиас:

rebuild

Обновление

nix flake update
sudo nixos-rebuild switch --flake .#nixos

Или одной командой:

nupdate

Git и Flakes

Новые файлы должны быть видимы Git до сборки Flake.

Например:

git add path/to/file

Иначе Nix может сообщить:

Path '...' does not exist in Git repository

Для локальной сборки делать commit необязательно — достаточно добавить новый файл в Git index.

Использование на другой машине

Конфигурация привязана к конкретному компьютеру.

Перед использованием на другом устройстве необходимо проверить как минимум:

- "hosts/nixos/hardware-configuration.nix"
- "hosts/nixos/hardware/disks.nix"
- "hosts/nixos/hardware/nvidia.nix"
- "hosts/nixos/hardware/bootloader.nix"
- "modules/users/default.nix"
- "modules/system/locale.nix"
- "modules/system/swap.nix"
- "home/popov/default.nix"
- "home/popov/monitors.nix"
- "home/popov/git.nix"

Также потребуется заменить имя пользователя "popov", домашний каталог и параметры оборудования.
