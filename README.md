<div align="center">

<h1>❄️ MyNixOS</h1>

<p>Моя персональная модульная конфигурация NixOS</p>

<a href="https://nixos.org/"><img src="https://img.shields.io/badge/NixOS-26.05-5277C3?logo=nixos&logoColor=white" alt="NixOS"></a>
<a href="https://kde.org/plasma-desktop/"><img src="https://img.shields.io/badge/KDE-Plasma%206-1D99F3?logo=kde&logoColor=white" alt="KDE Plasma"></a>
<a href="https://github.com/nix-community/home-manager"><img src="https://img.shields.io/badge/Home%20Manager-enabled-7EBAE4" alt="Home Manager"></a>
<a href="https://nixos.wiki/wiki/Flakes"><img src="https://img.shields.io/badge/Nix-Flakes-5277C3?logo=nixos&logoColor=white" alt="Flakes"></a>
<img src="https://img.shields.io/badge/arch-x86__64-lightgrey" alt="Architecture">

</div>

---

## 🖥️ Система

| Компонент | Конфигурация |
| --- | --- |
| OS | NixOS 26.05 |
| Архитектура | `x86_64-linux` |
| Desktop | KDE Plasma 6 |
| Display Manager | SDDM |
| User config | Home Manager |
| Plasma config | Plasma Manager |
| Bootloader | systemd-boot |
| Network | NetworkManager |
| Audio | PipeWire |
| GPU | Intel UHD 730 + NVIDIA GTX 1060 |
| Virtualization | QEMU/KVM + libvirt |

Основная Flake-конфигурация:

`nixosConfigurations.nixos`

---

## 🎨 KDE Plasma

Настройки Plasma отделены от системной конфигурации и находятся в:

`home/popov/kde-preset/`

| Модуль | Назначение |
| --- | --- |
| `appearance.nix` | Breeze, цвета и обои |
| `theme.nix` | общие параметры темы |
| `panel.nix` | нижняя панель |
| `shortcuts.nix` | горячие клавиши |
| `lockscreen.nix` | блокировка экрана |
| `power.nix` | питание и idle |
| `file-icons.nix` | MIME и кастомные иконки |
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

Нижняя панель Plasma настроена как единая полноразмерная панель.

| Параметр | Настройка |
| --- | --- |
| Положение | Bottom |
| Размер | На всю ширину |
| Floating | Нет |
| Скрытие | Auto Hide |
| Launcher | KDE Kickoff |
| System Tray | Да |
| Clock | Да |

Закреплены основные приложения:

`Dolphin` · `Konsole` · `Firefox` · `VS Code` · `Discord` · `Steam` · `System Settings` · `Virt-Manager` · `KDE Connect` · `Android Studio` · `Heroic` · `AyuGram`

---

## ⌨️ Горячие клавиши

| Комбинация | Действие |
| --- | --- |
| `Meta` | 🚀 Открыть меню приложений |
| `Meta + Enter` | 💻 Запустить Konsole |
| `Meta + Q` | ❌ Закрыть активное окно |
| `Meta + W` | 🪟 KDE Overview |
| `Meta + ,` | 🔎 Показать открытые окна |

«`Meta` — клавиша с логотипом Windows.»

---

## ❄️ Иконки `.nix`

Для Nix-файлов настроен отдельный MIME type и собственная SVG-иконка в стиле Breeze.

```text
*.nix
   │
   ▼
text/x-nix
   │
   ▼
text-x-nix.svg
```

В результате `.nix`-файлы в Dolphin сразу отличаются от обычных текстовых файлов.

---

## 🔐 SDDM

SDDM вынесен в отдельный системный модуль:

`modules/desktop/sddm.nix`

Экран входа используется вместе с KDE Plasma и оформляется в том же стиле.

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

Системная часть:

`modules/programs/gaming.nix`

Пользовательская часть:

```text
home/popov/gaming.nix
home/popov/mangohud.nix
```

### MangoHud

Настроено два отдельных профиля MangoHud.

| Профиль | Команда | Использование |
| --- | --- | --- |
| 🟢 Lite | `mangohud-lite` | компактный HUD для обычной игры |
| 🔵 Full | `mangohud-full` | подробная диагностика системы |

### 🟢 Lite

Показывает только основную информацию:

- FPS и frametime
- GPU load / temperature / power
- VRAM
- CPU load / temperature / power
- RAM
- GameMode
- Present Mode

### 🔵 Full

Полный диагностический профиль:

- FPS / frametime / FPS metrics
- GPU load
- GPU temperature
- GPU core и memory clocks
- GPU power и power limit
- VRAM
- CPU load
- CPU temperature
- CPU clocks
- CPU power
- загрузка отдельных ядер
- RAM и swap
- память процесса
- disk I/O
- Wine
- GameMode
- Present Mode
- Display Server
- Resolution
- информация о графическом стеке

---

## 🖥️ Hardware

### Graphics

| Компонент | Модель |
| --- | --- |
| iGPU | Intel UHD 730 |
| dGPU | NVIDIA GeForce GTX 1060 |
| Driver | NVIDIA proprietary |
| Modesetting | Enabled |
| Vulkan | Enabled |
| 32-bit graphics | Enabled |

Конфигурация:

`hosts/nixos/hardware/nvidia.nix`

### Monitors

`home/popov/monitors.nix`

### Audio

Используется PipeWire:

`PipeWire` · `ALSA` · `PulseAudio compatibility` · `RTKit`

Дополнительные инструменты:

`pavucontrol` · `qpwgraph` · `alsa-utils`

---

## 🖥️ Virtualization

| Компонент | Используется |
| --- | --- |
| KVM | ✅ |
| QEMU | ✅ |
| libvirt | ✅ |
| Virt-Manager | ✅ |
| Virt-Viewer | ✅ |
| swtpm | ✅ |
| SPICE | ✅ |
| USB Redirection | ✅ |

Основное подключение:

`qemu:///system`

Каталоги:

```text
~/VMs
~/VMs/images
/home/popov/Drives/HDD1/VMs
/home/popov/Drives/HDD1/VMs/iso
```

Конфигурация:

`modules/virtualization/default.nix`

---

## 🛠️ Development

| Категория | Инструменты |
| --- | --- |
| C / C++ | GCC, Make, CMake, GDB |
| Python | Python 3, pip, virtualenv |
| Android | Android Studio, ADB |
| JVM | JDK 17, Kotlin, Gradle |
| Editor | VS Code |

Системный development stack:

`modules/programs/base-dev.nix`

Пользовательский:

`home/popov/development.nix`

### 📱 adb-qr

В репозитории находится локальное Nix-описание стороннего проекта:

`packages/adb-qr/`

Оригинальный проект:

[aleixrodriala/adb-qr](https://github.com/aleixrodriala/adb-qr)

«`adb-qr` не является моим проектом.»

Локальный Nix derivation нужен для установки программы через эту конфигурацию, так как готового пакета в используемом Nixpkgs нет.

Программа позволяет выполнять Wireless ADB pairing через QR-код.

---

## 📦 Applications

| Категория | Программы |
| --- | --- |
| 🌐 Browser | Firefox |
| 💻 Development | VS Code, Android Studio |
| 💬 Communication | Discord, AyuGram |
| 🎨 Graphics | Darktable, Inkscape |
| 🎵 Multimedia | VLC, Strawberry |
| 📄 Office | LibreOffice |
| 📥 Torrents | qBittorrent |
| 📱 Android | scrcpy |
| 📊 Monitoring | btop, htop, nvtop, iotop |
| 🌐 Network | nethogs, bandwhich, tcpdump |
| 🛠️ Utilities | fzf, duf, tree, zip, unzip, p7zip |

---

## ⚡ Fastfetch

Fastfetch немного кастомизирован:

`home/popov/fastfetch.nix`

Используется встроенный логотип NixOS и собственная структура вывода:

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

Дополнительно настроены:

- собственные цвета ключей;
- разделители;
- ширина колонок;
- формат мониторов;
- IEC-формат размера памяти;
- ссылка на GitHub.

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
| `nupdate` | обновить Flake и сделать rebuild |
| `nclean` | удалить старые поколения Nix |
| `watchnvidia` | `nvidia-smi` каждую секунду |
| `grep` | цветной вывод grep |

### Основные команды

```bash
rebuild
nbuild
ntest
nupdate
nclean
watchnvidia
```

### rebuildVPN

Также определена Bash-функция:

`rebuildVPN <server> <ip>`

Она выполняет удалённый `nixos-rebuild` отдельного VPN-сервера через SSH.

---

## 📁 Структура репозитория

<details>
<summary><b>Показать дерево файлов</b></summary>

```text
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
│       │
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
│       │
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
│   │
│   ├── programs/
│   │   ├── base-dev.nix
│   │   ├── default.nix
│   │   ├── gaming.nix
│   │   ├── obs.nix
│   │   └── packages.nix
│   │
│   ├── system/
│   │   ├── boot.nix
│   │   ├── default.nix
│   │   ├── locale.nix
│   │   ├── network.nix
│   │   ├── nix-settings.nix
│   │   ├── ssh.nix
│   │   └── swap.nix
│   │
│   ├── users/
│   │   └── default.nix
│   │
│   └── virtualization/
│       └── default.nix
│
├── packages/
│   └── adb-qr/
│       └── default.nix
│
├── README.md
└── README.en.md
```

</details>

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

`sudo nixos-rebuild build --flake .#nixos`

или:

`nbuild`

### Протестировать

`sudo nixos-rebuild test --flake .#nixos`

или:

`ntest`

### Применить

`sudo nixos-rebuild switch --flake .#nixos`

или просто:

`rebuild`

---

## 🔄 Update

```bash
nix flake update
sudo nixos-rebuild switch --flake .#nixos
```

или:

`nupdate`

---

## Git + Flakes

Новые файлы должны быть добавлены в Git index перед сборкой:

`git add path/to/file`

Иначе Flake может выдать:

`Path '...' does not exist in Git repository`

Коммит для локальной сборки не обязателен.

---

## ⚠️ Использование на другой машине

Конфигурация привязана к конкретному компьютеру.

Перед использованием стоит проверить:

| Файл | Что изменить |
| --- | --- |
| `hardware-configuration.nix` | файловые системы и hardware |
| `hardware/nvidia.nix` | GPU и драйвер |
| `hardware/disks.nix` | диски |
| `hardware/bootloader.nix` | загрузчик |
| `users/default.nix` | пользователь |
| `locale.nix` | язык и timezone |
| `swap.nix` | swap / zram |
| `monitors.nix` | конфигурация мониторов |
| `git.nix` | Git user / email |

Также потребуется заменить:

popov
`/home/popov`

на данные другого пользователя.
