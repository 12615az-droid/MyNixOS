# MyNixOS

Персональная конфигурация NixOS для компьютера `nixos` на `x86_64-linux`.

Конфигурация собрана через Nix Flakes. Системные настройки находятся в `modules/`, пользовательские программы и настройки — в `home/` через Home Manager.

## Что настроено

### Основа

- NixOS 26.05
- Nix Flakes
- Home Manager 26.05
- Plasma Manager
- разрешены unfree-пакеты
- `nix-ld` для запуска обычных Linux-бинарников
- автоматическая очистка поколений старше 14 дней
- еженедельная оптимизация Nix Store

### Загрузка и система

- systemd-boot
- UEFI
- хранение последних 5 поколений загрузки
- Plymouth
- тихая загрузка
- NetworkManager
- часовой пояс `Europe/Minsk`
- локаль `ru_RU.UTF-8`
- раскладки `us,ru`, переключение `Alt+Shift`
- CUPS для печати

### Рабочее окружение

Доступны две графические сессии:

- KDE Plasma 6 + SDDM
- Hyprland + XWayland

Для Plasma через Plasma Manager настроены:

- Breeze Dark
- Noto Sans и JetBrains Mono
- горячие клавиши
- отключение автоматического сна и выключения экрана от сети
- настройки блокировки экрана

Для Hyprland настроены:

- Kitty
- Waybar
- Rofi
- Mako
- история буфера обмена через Cliphist
- скриншоты через Grim, Slurp и Swappy
- управление звуком и мультимедиа
- рабочие столы и горячие клавиши
- Wayland-настройки для Electron, Firefox и Qt

### Видео и мониторы

- проприетарный драйвер NVIDIA
- пакет драйвера `legacy_580` для GTX 1060
- NVIDIA modesetting
- 32-битные графические библиотеки для Steam и Proton
- сохранение видеопамяти при suspend/resume
- профиль двух мониторов через autorandr:
  - `DP-2` — 1920x1200, основной
  - `HDMI-0` — 1920x1080, справа

### Звук

- PipeWire
- ALSA
- 32-битная поддержка ALSA
- PulseAudio-совместимость
- RTKit
- `pavucontrol`, `qpwgraph`, `alsa-utils`

### Игры

- Steam
- GameMode
- MangoHud
- Heroic Games Launcher
- Legendary
- ProtonUp-Qt
- Gamescope
- Lutris
- Vulkan Tools
- Mesa Demos

### Виртуализация

- libvirt
- QEMU/KVM
- Virt-Manager
- Virt-Viewer
- swtpm
- SPICE и USB redirection
- системное подключение `qemu:///system`
- каталоги виртуальных машин в `~/VMs` и на `HDD1`

### Диски и swap

- автоматическое монтирование двух ext4-дисков:
  - `/home/popov/Drives/HDD1`
  - `/home/popov/Drives/Toshiba`
- zram со сжатием `zstd`
- размер zram — до 100% оперативной памяти
- резервный swapfile `/var/lib/swapfile` размером 16 ГиБ

### Разработка

Системные инструменты:

- GCC
- GNU Make
- CMake
- pkg-config
- GDB
- Python 3
- pip
- virtualenv

Пользовательские инструменты:

- VS Code
- Android Studio
- Android Tools
- JDK 17
- Kotlin
- Gradle

### Программы

- Firefox
- Kate
- Spectacle
- LibreOffice
- VLC
- Strawberry
- Darktable
- Discord
- AyuGram Desktop
- scrcpy
- ActivityWatch
- Fastfetch
- btop
- htop
- iotop
- nethogs
- bandwhich
- fzf
- системные и дисковые утилиты

## Структура

```text
.
├── flake.nix                    # Входы и сборка nixosConfigurations.nixos
├── flake.lock                   # Зафиксированные версии входов
├── configuration.nix           # Главный список системных модулей
├── hardware-configuration.nix  # Конфигурация оборудования этой машины
├── modules/
│   ├── audio.nix               # PipeWire и звук
│   ├── base-dev.nix            # Базовые инструменты разработки
│   ├── boot.nix                # systemd-boot, Plymouth, тихая загрузка
│   ├── desktop-hyprland.nix    # Hyprland и системные Wayland-утилиты
│   ├── desktop-kde.nix         # Plasma 6, SDDM, раскладки, KDE Connect
│   ├── disks.nix               # Монтирование дополнительных дисков
│   ├── gaming.nix              # Steam, GameMode, Vulkan
│   ├── hardware-nvidia.nix     # Драйвер и настройки NVIDIA
│   ├── locale.nix              # Локаль, часовой пояс, консольная раскладка
│   ├── network.nix             # Имя хоста и NetworkManager
│   ├── nix-settings.nix        # Flakes, unfree, nix-ld, GC и оптимизация
│   ├── packages.nix            # Базовые системные программы
│   ├── swap.nix                # zram и swapfile
│   ├── users.nix               # Пользователь popov и его группы
│   └── virtualization.nix      # libvirt, QEMU/KVM, Virt-Manager и SPICE
└── home/
    ├── popov.nix               # Главный модуль Home Manager
    ├── packages.nix            # Пользовательские программы
    ├── development.nix         # IDE, Java, Kotlin и Android
    ├── gaming.nix              # MangoHud и игровые лаунчеры
    ├── git.nix                 # Настройки Git
    ├── shell.nix               # Bash и алиасы
    ├── kde-preset.nix          # Настройки Plasma Manager
    ├── hyprland.nix            # Установка конфигов Hyprland/Waybar/Mako
    ├── baloo.nix               # Исключения индексатора Baloo
    ├── monitors.nix            # Профиль двух мониторов autorandr
    ├── hypr/hyprland.conf      # Основной конфиг Hyprland
    ├── waybar/config.jsonc     # Модули Waybar
    ├── waybar/style.css        # Оформление Waybar
    └── mako/config             # Настройки уведомлений Mako
```

## Сборка и применение

Из каталога репозитория:

```bash
sudo nixos-rebuild build --flake .#nixos
sudo nixos-rebuild test --flake .#nixos
sudo nixos-rebuild switch --flake .#nixos
```

Если конфигурация находится в `/etc/nixos`:

```bash
sudo nixos-rebuild switch --flake /etc/nixos#nixos
```

Обновление входов Flake и системы:

```bash
sudo nix flake update
sudo nixos-rebuild switch --flake .#nixos
```

## Bash-алиасы

| Алиас | Действие |
|---|---|
| `rebuild` | Применить `/etc/nixos#nixos` |
| `nbuild` | Только собрать конфигурацию |
| `ntest` | Временно протестировать конфигурацию |
| `nupdate` | Обновить Flake и применить систему |
| `nclean` | Удалить старые поколения и мусор Nix |
| `nix2home` | Скопировать `/etc/nixos` в `~/MyNixOS` |
| `home2nix-check` | Проверить синхронизацию `~/MyNixOS` → `/etc/nixos` без записи |
| `home2nix` | Скопировать `~/MyNixOS` в `/etc/nixos` |
| `watchnvidia` | Наблюдать обычный вывод `nvidia-smi` |
| `watchnvidiab` | Наблюдать краткую статистику NVIDIA |

## Что изменить для другой машины

Конфигурация привязана к конкретному компьютеру. Перед применением нужно проверить:

- `hardware-configuration.nix` — оборудование и файловые системы
- `flake.nix` — имя конфигурации `nixos` и пользователь Home Manager
- `modules/users.nix` — имя пользователя, UID и группы
- `home/popov.nix` — имя пользователя и домашний каталог
- `modules/hardware-nvidia.nix` — модель видеокарты и пакет драйвера
- `modules/disks.nix` — UUID дисков и точки монтирования
- `modules/swap.nix` — размер swapfile и параметры zram
- `home/monitors.nix` — выходы, EDID, разрешения и расположение мониторов
- `home/git.nix` — имя и email Git
- `modules/locale.nix` — часовой пояс и локаль
