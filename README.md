```markdown
# MyNixOS Config

NixOS 26.05 (Yarara) x86_64 | Kernel 6.18.36

## Структура

```
configuration.nix          — точка входа, импортирует модули
hardware-configuration.nix — авто-сгенерировано при установке
modules/
├── boot.nix
├── network.nix
├── locale.nix
├── desktop-kde.nix
├── audio.nix
├── users.nix
├── nix-settings.nix
├── gaming.nix
├── development.nix
├── packages.nix
├── hardware-nvidia.nix
├── disks.nix
└── virtualization.nix
```

## Железо

| Компонент | Модель |
|-----------|--------|
| CPU | Intel Core i5-11400 (6C/12T, 4.40 GHz) |
| GPU | NVIDIA GeForce GTX 1060 3 GB |
| RAM | 16 GB (15.49 GiB usable) |
| Материнка | B560 HD3 |
| Диск системный | 500 GB SSD (ext4) |
| Диск HDD1 | 1.17 TB NTFS |
| Диск HDD2 | 662 GB NTFS |
| Swap | Отключен |

## Дисплеи

| Монитор | Разрешение | Частота |
|---------|-----------|---------|
| DELL U2412M | 1920×1200 | 60 Hz |
| LG Full HD | 1920×1080 | 75 Hz |

DE: KDE Plasma 6.6.5 | WM: KWin (X11) | Тема: Breeze Light

## Модули

### boot.nix
- Загрузчик: systemd-boot (EFI)
- Лимит: 5 конфигураций в истории

### network.nix
- Hostname: `nixos`
- NetworkManager
- Firewall доверяет `virbr0` (libvirt NAT)

### locale.nix
- Часовой пояс: Europe/Minsk
- Локаль: ru_RU.UTF-8
- Консоль: US раскладка

### desktop-kde.nix
- Plasma 6 + SDDM
- Раскладки: US, RU (переключение Alt+Shift)
- KDE Connect
- dconf

### audio.nix
- PipeWire (PulseAudio отключен)
- ALSA + 32-bit поддержка

### users.nix
- Пользователь: `popov`
- Группы: networkmanager, wheel, kvm, libvirtd
- Личные пакеты: Kate

### nix-settings.nix
- Unfree пакеты разрешены
- Экспериментальные фичи: nix-command, flakes

### gaming.nix
- Steam (Remote Play, LAN transfers)
- Gamemode
- MangoHud
- ProtonUp-Qt
- Vulkan Tools, Mesa Demos

### development.nix
- Java 17 (JDK)
- Python 3 + pip + virtualenv
- Kotlin + Gradle
- VS Code
- Android Studio + Android Tools
- Системные: git, gcc, gnumake, cmake, pkg-config, gdb

### packages.nix
- Браузер: Firefox
- Офис: LibreOffice
- Фото: Darktable
- Аудио: Strawberry
- Видео: VLC
- Мессенджеры: Ayugram, Discord
- Редакторы: micro, vim
- Мониторинг: btop, htop, fastfetch
- Архиваторы: unzip, zip, p7zip
- KDE: Spectacle, KSystemStats
- Прочее: duf, pciutils, usbutils, lm_sensors, ActivityWatch

### hardware-nvidia.nix
- Драйвер: закрытый legacy_580
- Modesetting, nvidia-settings
- Power management (фикс suspend)
- nvidiaPersistenced
- 32-bit библиотеки
- PreserveVideoMemoryAllocations

### disks.nix
- NTFS3 поддержка в ядре
- HDD1: `/home/popov/Drives/HDD1` (1.17 TB, 59% занято)
- HDD2: `/home/popov/Drives/HDD2` (662 GB, 2% занято)
- Авто-монтирование, 5-минутный idle-timeout, nofail

### virtualization.nix
- QEMU/KVM через libvirt
- Virt-Manager
- TPM эмуляция (swtpm)
- USB-проброс (SPICE)
- Папки: `~/VMs`, `~/Drives/HDD1/VMs`

## Состояние системы

| Параметр | Значение |
|----------|----------|
| Uptime | 4ч 31м |
| Пакеты | 1770 (nix-system: 390, nix-user: 1380) |
| Shell | bash 5.3.9 |
| Терминал | konsole 26.4.2 |
| Шрифт | Noto Sans 10pt |
| Локальный IP | 192.168.1.138/24 |

## Заметки

- `stateVersion = "26.05"` — версия ещё не выпущена
- Flake не используется
- Репозиторий приватный
- Swap не настроен (16 GB RAM)
```
