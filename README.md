<div align="center">

# ❄️ MyNixOS

Моя персональная модульная конфигурация NixOS для основного ПК.

[![NixOS](https://img.shields.io/badge/NixOS-26.05-5277C3?logo=nixos&logoColor=white)](https://nixos.org/)
[![KDE Plasma](https://img.shields.io/badge/KDE-Plasma%206-1D99F3?logo=kde&logoColor=white)](https://kde.org/plasma-desktop/)
[![Home Manager](https://img.shields.io/badge/Home%20Manager-enabled-7EBAE4)](https://github.com/nix-community/home-manager)
[![Flakes](https://img.shields.io/badge/Nix-Flakes-5277C3?logo=nixos&logoColor=white)](https://nixos.wiki/wiki/Flakes)
![Architecture](https://img.shields.io/badge/arch-x86__64-lightgrey)
![CPU](https://img.shields.io/badge/CPU-Ryzen%207%209700X-EF0707?logo=amd&logoColor=white)
![GPU](https://img.shields.io/badge/GPU-Radeon%20RX%205700%20XT-EF0707?logo=amd&logoColor=white)

</div>

---

## 🖥️ Система

| Компонент | Конфигурация |
| --- | --- |
| OS | NixOS 26.05 |
| Архитектура | `x86_64-linux` |
| Desktop | KDE Plasma 6 |
| Session | KWin / Wayland |
| Display Manager | SDDM |
| User config | Home Manager |
| Plasma config | Plasma Manager |
| Bootloader | systemd-boot |
| Network | NetworkManager |
| Audio | PipeWire |
| CPU | AMD Ryzen 7 9700X |
| GPU | AMD Radeon RX 5700 XT + AMD Radeon Graphics |
| Graphics stack | `amdgpu` + Mesa |
| RAM | 32 GiB |
| Virtualization | QEMU/KVM + libvirt |
| Android container | Waydroid |

Основная Flake-конфигурация:

```text
nixosConfigurations.nixos
```

Входная точка системы:

```text
configuration.nix
├── hosts/nixos
├── modules
└── home
```

---

## 🧠 Hardware

### CPU

| Параметр | Значение |
| --- | --- |
| CPU | AMD Ryzen 7 9700X |
| Архитектура | Zen 5 / AM5 |
| Ядра / потоки | 8 / 16 |
| Аппаратная виртуализация | AMD-V / KVM |
| Kernel module | `kvm-amd` |

### Graphics

| Компонент | Модель |
| --- | --- |
| dGPU | AMD Radeon RX 5700 XT |
| iGPU | AMD Radeon Graphics |
| Kernel driver | `amdgpu` |
| Userspace | Mesa |
| Vulkan | Enabled |
| 32-bit graphics | Enabled |

GPU-конфигурация:

```text
hosts/nixos/hardware/amdgpu.nix
modules/desktop/graphics.nix
```

Вся старая конфигурация NVIDIA больше не используется.

### Monitors

Текущая конфигурация — два Full HD монитора:

```text
1920×1080 @ ~75 Hz
1920×1080 @ ~60 Hz
```

Пользовательские настройки мониторов находятся в:

```text
home/popov/monitors.nix
```

### Storage

Системный SSD:

```text
/
├── Btrfs
├── /home → Btrfs subvolume
└── /nix  → Btrfs subvolume
```

Дополнительный диск:

```text
/home/popov/Drives/HDD1
└── ext4, 2 TB
```

HDD монтируется декларативно через systemd automount.

Конфигурация:

```text
hosts/nixos/hardware-configuration.nix
hosts/nixos/hardware/disks.nix
```

### OpenRGB

OpenRGB включён как системный сервис с профилем для AMD-платформы.

```text
hosts/nixos/hardware/nonrgb.nix
```

---

## 🎨 KDE Plasma

Настройки Plasma вынесены в отдельные Home Manager / Plasma Manager модули:

```text
home/popov/kde-preset/
```

| Модуль | Назначение |
| --- | --- |
| `appearance.nix` | внешний вид, цвета и обои |
| `theme.nix` | общие параметры темы |
| `panel.nix` | нижняя панель Plasma |
| `shortcuts.nix` | горячие клавиши |
| `lockscreen.nix` | экран блокировки |
| `power.nix` | питание и idle |
| `keyboard.nix` | параметры клавиатуры |
| `file-icons.nix` | MIME и кастомные иконки |
| `file-templates.nix` | шаблон создания `.nix`-файлов |
| `icons/` | пользовательские SVG |

### Внешний вид

| Параметр | Значение |
| --- | --- |
| Look & Feel | Breeze |
| Color Scheme | Breeze Light |
| Icons | Breeze |
| Wallpaper | Scarlet Tree |
| Accent | 🟣 `#6D28D9` |

### Панель

Нижняя панель Plasma:

- расположена снизу;
- растянута на всю ширину;
- не floating;
- автоматически скрывается;
- используется на всех мониторах;
- содержит Kickoff, Task Manager, System Tray, часы и Show Desktop.

Закреплены основные приложения:

`Dolphin` · `Konsole` · `Firefox` · `VS Code` · `Discord` · `Steam` · `System Settings` · `Virt-Manager` · `KDE Connect` · `Android Studio` · `Heroic` · `AyuGram`

---

## ❄️ Интеграция Nix в Dolphin

Для `.nix` настроен собственный MIME type и SVG-значок:

```text
*.nix
   │
   ▼
text/x-nix
   │
   ▼
text-x-nix.svg
```

Также в меню Dolphin **Создать** добавлен шаблон Nix-файла.

Созданный файл является обычным файлом, а не symlink на `/nix/store`.

---

## ⌨️ Горячие клавиши

| Комбинация | Действие |
| --- | --- |
| `Meta` | открыть меню приложений |
| `Meta + Enter` | запустить Konsole |
| `Meta + Q` | закрыть активное окно |
| `Meta + W` | KDE Overview |
| `Meta + ,` | показать открытые окна |

---

## 🔊 Audio

Используется PipeWire:

```text
PipeWire
├── ALSA
├── ALSA 32-bit
├── PulseAudio compatibility
└── RTKit
```

Дополнительные инструменты:

`pavucontrol` · `qpwgraph` · `alsa-utils`

Конфигурация:

```text
modules/desktop/audio.nix
```

---

## 🎮 Gaming

| Компонент | Назначение |
| --- | --- |
| Steam | основной игровой клиент |
| GameMode | оптимизация системы во время игры |
| Heroic | Epic / GOG |
| Legendary | CLI для Epic |
| ProtonUp-Qt | управление Proton |
| Gamescope | игровой compositor |
| Lutris | запуск сторонних игр |
| MangoHud | игровой мониторинг |
| Vulkan Tools | диагностика Vulkan |
| Mesa Demos | диагностика Mesa/OpenGL |

Системная часть:

```text
modules/programs/gaming.nix
```

Пользовательская часть:

```text
home/popov/gaming.nix
home/popov/mangohud.nix
```

### MangoHud

Используются два профиля:

| Профиль | Команда | Назначение |
| --- | --- | --- |
| 🟢 Lite | `mangohud-lite` | компактный игровой HUD |
| 🔵 Full | `mangohud-full` | подробная диагностика |

---

## 🖥️ Virtualization

Основной стек виртуализации:

| Компонент | Статус |
| --- | --- |
| AMD-V / KVM | ✅ |
| QEMU | ✅ |
| libvirt | ✅ |
| Virt-Manager | ✅ |
| Virt-Viewer | ✅ |
| swtpm | ✅ |
| SPICE | ✅ |
| USB Redirection | ✅ |
| virtiofsd | ✅ |

Основное подключение:

```text
qemu:///system
```

Каталоги:

```text
~/VMs
~/VMs/images
/home/popov/Drives/HDD1/VMs
/home/popov/Drives/HDD1/VMs/iso
```

Конфигурация:

```text
modules/virtualization/default.nix
```

### Waydroid

Waydroid используется для запуска Android-приложений непосредственно в Wayland-сессии.

```text
modules/virtualization/waydroid.nix
```

---

## 🛠️ Development

| Категория | Инструменты |
| --- | --- |
| C / C++ | GCC, Make, CMake, GDB |
| Python | Python 3, pip, virtualenv |
| Android | Android Studio, ADB, scrcpy |
| JVM | JDK 17, Kotlin, Gradle |
| Editors | VS Code, Zed |
| Secrets | agenix |

Системный development stack:

```text
modules/programs/base-dev.nix
```

Пользовательская конфигурация:

```text
home/popov/development.nix
```

### 📱 adb-qr

В репозитории находится локальный Nix derivation для стороннего проекта:

```text
packages/adb-qr/
```

Оригинальный проект: [aleixrodriala/adb-qr](https://github.com/aleixrodriala/adb-qr)

`adb-qr` используется для Wireless ADB pairing через QR-код.

---

## 📦 Applications

| Категория | Программы |
| --- | --- |
| 🌐 Browser | Firefox |
| 💻 Development | VS Code, Zed, Android Studio |
| 💬 Communication | Discord, AyuGram |
| 🎨 Graphics | Darktable, Inkscape |
| 🎵 Multimedia | VLC, Strawberry |
| 📄 Office | LibreOffice |
| 📥 Torrents | qBittorrent |
| 📱 Android | scrcpy, Waydroid |
| 📊 Monitoring | btop, htop, nvtop, iotop |
| 🌐 Network | nethogs, bandwhich, tcpdump |
| 🛠️ Utilities | fzf, duf, tree, zip, unzip, p7zip |

---

## ⚡ Fastfetch

Fastfetch настроен через:

```text
home/popov/fastfetch.nix
```

Вывод разделён на три основных блока:

```text
──────────── USER ─────────────

user@host
GitHub : github.com/12615az-droid

───────────── OS ──────────────

OS
Kernel
Uptime
Packages
Desktop
Session

────────── HARDWARE ───────────

Host
Monitor
CPU
GPU
Memory
Disk
```

На текущем железе Fastfetch показывает Ryzen 7 9700X, Radeon RX 5700 XT, встроенную Radeon Graphics и два Full HD монитора.

---

## 🐚 Bash

Конфигурация:

```text
home/popov/shell.nix
home/popov/function.nix
```

### Алиасы

| Алиас | Действие |
| --- | --- |
| `ll` | `ls -lah` |
| `sbtop` | запустить `btop` через sudo |
| `rebuild` | применить текущую конфигурацию |
| `nbuild` | собрать без переключения |
| `ntest` | протестировать конфигурацию |
| `nupdate` | обновить Flake и выполнить rebuild |
| `nclean` | удалить старые поколения Nix |
| `grep` | цветной вывод grep |

Основные команды:

```bash
rebuild
nbuild
ntest
nupdate
nclean
```

### rebuildVPN

Для удалённой сборки VPN-сервера определена функция:

```bash
rebuildVPN <server> <ip>
```

---

## 📁 Структура репозитория

Упрощённая структура:

```text
MyNixOS/
├── configuration.nix
├── flake.nix
├── flake.lock
├── README.md
├── README.en.md
│
├── hosts/
│   └── nixos/
│       ├── default.nix
│       ├── hardware-configuration.nix
│       └── hardware/
│           ├── default.nix
│           ├── amdgpu.nix
│           ├── bootloader.nix
│           ├── disks.nix
│           └── nonrgb.nix
│
├── modules/
│   ├── default.nix
│   ├── desktop/
│   ├── programs/
│   ├── system/
│   ├── users/
│   └── virtualization/
│       ├── default.nix
│       └── waydroid.nix
│
├── home/
│   ├── default.nix
│   └── popov/
│       ├── default.nix
│       ├── development.nix
│       ├── fastfetch.nix
│       ├── function.nix
│       ├── gaming.nix
│       ├── mangohud.nix
│       ├── packages.nix
│       ├── shell.nix
│       └── kde-preset/
│           ├── default.nix
│           ├── appearance.nix
│           ├── file-icons.nix
│           ├── file-templates.nix
│           ├── keyboard.nix
│           ├── lockscreen.nix
│           ├── panel.nix
│           ├── power.nix
│           ├── shortcuts.nix
│           ├── theme.nix
│           └── icons/
│
└── packages/
    └── adb-qr/
```

### Разделение

| Каталог | Назначение |
| --- | --- |
| `hosts/` | настройки конкретной машины |
| `modules/` | системные NixOS-модули |
| `home/` | Home Manager и пользовательские настройки |
| `packages/` | локальные Nix package definitions |

---

## 🚀 Build

### Собрать

```bash
sudo nixos-rebuild build --flake .#nixos
```

или:

```bash
nbuild
```

### Протестировать

```bash
sudo nixos-rebuild test --flake .#nixos
```

или:

```bash
ntest
```

### Применить

```bash
sudo nixos-rebuild switch --flake .#nixos
```

или:

```bash
rebuild
```

---

## 🔄 Update

```bash
nix flake update
sudo nixos-rebuild switch --flake .#nixos
```

или:

```bash
nupdate
```

---

## 🌿 Git + Flakes

Новые файлы должны быть добавлены в Git index перед сборкой:

```bash
git add path/to/file
```

Иначе Flake может не увидеть новый файл.

Коммит для локальной сборки не обязателен.

---

## ⚠️ Использование на другой машине

Конфигурация привязана к конкретному компьютеру.

Перед использованием на другом железе необходимо проверить как минимум:

| Файл | Что изменить |
| --- | --- |
| `hosts/nixos/hardware-configuration.nix` | файловые системы и обнаруженное оборудование |
| `hosts/nixos/hardware/amdgpu.nix` | графика / GPU |
| `hosts/nixos/hardware/disks.nix` | дополнительные диски |
| `hosts/nixos/hardware/bootloader.nix` | загрузчик |
| `modules/users/default.nix` | пользователь |
| `modules/system/locale.nix` | язык и timezone |
| `modules/system/swap.nix` | swap / zram |
| `home/popov/monitors.nix` | конфигурация мониторов |
| `home/popov/git.nix` | Git user / email |

Также потребуется заменить:

```text
popov
/home/popov
```

на данные другого пользователя.

---

<div align="center">

**Ryzen 7 9700X · Radeon RX 5700 XT · KDE Plasma · NixOS**

</div>
