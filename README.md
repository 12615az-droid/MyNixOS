<div align="center">

# ❄️ MyNixOS

**Персональная модульная конфигурация NixOS для основного ПК**

[English version](README.en.md)

[![NixOS](https://img.shields.io/badge/NixOS-26.05-5277C3?logo=nixos&logoColor=white)](https://nixos.org/)
[![KDE Plasma](https://img.shields.io/badge/KDE-Plasma%206-1D99F3?logo=kde&logoColor=white)](https://kde.org/plasma-desktop/)
[![Home Manager](https://img.shields.io/badge/Home%20Manager-enabled-7EBAE4)](https://github.com/nix-community/home-manager)
[![Flakes](https://img.shields.io/badge/Nix-Flakes-5277C3?logo=nixos&logoColor=white)](https://wiki.nixos.org/wiki/Flakes)
![Architecture](https://img.shields.io/badge/arch-x86__64--linux-lightgrey)

</div>

> [!IMPORTANT]
> Это конфигурация конкретного компьютера, а не универсальный установщик. Перед применением на другой машине обязательно замените UUID дисков, имя пользователя, домашний каталог, SSH-ключ и аппаратные настройки.

## Обзор

Flake описывает один хост — `nixos` — и объединяет системные модули NixOS, пользовательскую конфигурацию Home Manager и настройки Plasma Manager.

| Компонент | Настройка |
| --- | --- |
| Канал | NixOS / Home Manager `26.05` |
| Архитектура | `x86_64-linux` |
| Хост | `nixos` |
| Пользователь | `popov` (UID 1000) |
| Рабочий стол | KDE Plasma 6, SDDM |
| Графика | AMDGPU, Mesa, Vulkan и 32-битный графический стек |
| Сеть | NetworkManager, Tailscale |
| Звук | PipeWire + ALSA/PulseAudio compatibility |
| Загрузка | UEFI, systemd-boot, Plymouth |
| Файловая система | Btrfs для `/`, `/home` и `/nix`; отдельный ext4 HDD |
| Виртуализация | KVM/QEMU, libvirt, virt-manager, SPICE, swtpm, virtiofsd |
| Android | Waydroid с nftables |
| Игры | Steam, GameMode, Gamescope, Lutris, Heroic, MangoHud |

Главный выход flake:

```text
nixosConfigurations.nixos
```

Поток импорта:

```text
flake.nix
└── configuration.nix
    ├── hosts/nixos       # хост и конкретное оборудование
    ├── modules           # переиспользуемые системные возможности
    └── home              # Home Manager для popov
```

## Структура репозитория

```text
.
├── flake.nix                         # входы и nixosConfigurations.nixos
├── flake.lock                        # зафиксированные ревизии зависимостей
├── configuration.nix                 # общая точка входа, stateVersion
├── hosts/nixos/
│   ├── default.nix                   # hostname и импорт hardware/
│   ├── hardware-configuration.nix    # разделы, загрузочные модули, платформа
│   └── hardware/                     # AMDGPU, bootloader, HDD, OpenRGB, датчики
├── modules/
│   ├── system/                       # boot, locale, Nix, сеть, SSH, swap
│   ├── desktop/                      # Plasma, SDDM, PipeWire, Bluetooth, печать
│   ├── programs/                     # базовая разработка, Steam, OBS, пакеты
│   ├── users/                        # пользователь popov и SSH-ключ
│   └── virtualization/               # libvirt/QEMU и Waydroid
├── home/popov/
│   ├── default.nix                   # список пользовательских модулей
│   ├── kde-preset/                   # Plasma Manager и интеграция Dolphin
│   ├── wallpaper/                    # набор обоев
│   └── *.nix                         # приложения, shell, Git, мониторинг и т. д.
└── packages/adb-qr/default.nix       # локальный derivation adb-qr
```

## Системная конфигурация

### Загрузка и оборудование

- systemd-boot хранит не более пяти поколений, запрещает редактирование записей и ждёт 3 секунды;
- Plymouth и тихие параметры ядра сокращают вывод при старте;
- загружается внешний модуль `nct6687` для аппаратного мониторинга, а `nct6683` блокируется;
- для Wi-Fi-драйвера `rtw89_core` отключён энергосберегающий режим;
- AMDGPU выбран как X.Org-драйвер, а Mesa включена и для 64-, и для 32-битных приложений;
- включены LACT, AMDGPU overdrive и CoolerControl;
- OpenRGB запускается системным сервисом с профилем `norm2.orp`.

Системный накопитель использует один Btrfs-раздел для `/` и подтомов `/home` и `/nix`. EFI-раздел смонтирован в `/boot`. Дополнительный ext4 HDD монтируется по требованию в `/home/popov/Drives/HDD1` и отключается после 300 секунд простоя. UUID в конфигурации относятся только к исходному компьютеру.

### Память и swap

Настроены два уровня swap:

- zram со сжатием Zstandard, размером до 100% RAM и приоритетом 100;
- swap-файл `/var/lib/swapfile` размером 16 GiB и приоритетом 10.

Также установлены `vm.swappiness = 100` и `vm.page-cluster = 0`.

### Сеть и удалённый доступ

NetworkManager управляет сетью, энергосбережение Wi-Fi отключено, Tailscale включён. UDP-порт 5353 открыт для mDNS.

OpenSSH запускается как системный сервис и открывает порт в firewall. Вход разрешён только пользователю `popov`, только по ключу; root-вход, парольная и keyboard-interactive аутентификация отключены. Home Manager дополнительно создаёт клиентский alias `my-server`. Файл `adGuardVpn.nix` устанавливает `wireguard-tools`, `qrencode` и клиент OpenSSH, но сам VPN-туннель не создаёт.

### Локаль и ввод

- часовой пояс: `Europe/Minsk`;
- системная локаль: `ru_RU.UTF-8`;
- консольная раскладка: US;
- в Plasma доступны US и RU с глобальной политикой переключения.

В системном XKB задано `Alt+Shift`, а в Plasma Manager — `Meta+Space`. Если поведение раскладки окажется неоднозначным, оставьте один способ переключения.

### Desktop и мультимедиа

Plasma 6 работает через SDDM. Тема SDDM собирается из Breeze и использует те же обои, что и рабочий стол. KDE Connect и dconf включены.

PipeWire предоставляет ALSA, 32-битную ALSA и совместимость с PulseAudio; RTKit выдаёт звуковым процессам приоритет реального времени. Пользовательский oneshot-сервис `fix-headphones` запускается вместе с сессией, ждёт готовности PipeWire/WirePlumber и через `pactl` автоматически выбирает порт `analog-output-headphones`, когда разъём передней панели доступен. Для диагностики установлены `pavucontrol`, `qpwgraph` и `alsa-utils`.

Для принтеров и сканеров включены CUPS, SANE, проприетарный плагин HPLIP и Simple Scan. Пользователь добавлен в группы `lp` и `scanner`.

## KDE Plasma и Dolphin

`home/popov/kde-preset/` декларативно задаёт:

- Breeze/Breeze Light, набор значков Breeze и фиолетовый accent `#6A0DAD`;
- слайд-шоу из `home/popov/wallpaper/` с интервалом 24 часа;
- нижнюю непрозрачную панель высотой 48 px на всех экранах с автоскрытием;
- пустую новую сессию, отсутствие автосна и отключения дисплея от сети;
- отсутствие автоматической блокировки и блокировки после resume;
- закреплённые Dolphin, Konsole, Firefox, Discord, Steam, System Settings, virt-manager, KDE Connect, Android Studio, Zed, Heroic и AyuGram;
- место `MyNixOS` в боковой панели Dolphin.

Горячие клавиши:

| Сочетание | Действие |
| --- | --- |
| `Meta` / `Alt+F1` | меню приложений |
| `Meta+Enter` | Konsole |
| `Meta+Q` | закрыть активное окно |
| `Meta+W` | Overview |
| `Meta+,` | показать окна |

Для `*.nix` регистрируется MIME-тип `text/x-nix`, собственная иконка файла и шаблон «Nix File» в меню создания Dolphin. Activation-скрипт назначает Nix-иконку каталогам, содержащим `.nix` непосредственно внутри, в деревьях `~/MyNixOS` и `~/NixOS-vpnServer`. Файл `.nix-icon` включает её принудительно, `.no-nix-icon` отключает; чужие `.directory` не перезаписываются.

## Программы

### Разработка

- системно: GCC, Make, CMake, pkg-config, GDB, Python 3, pip, virtualenv и JDK 8;
- в профиле пользователя: Android Studio, Android platform-tools/ADB, JDK 17, Kotlin, Gradle и Codex;
- Zed с расширениями Nix, Kotlin, Java и XML, `nixd`, `nixfmt`, JetBrains Mono и темой NIX//UNDERGROUND;
- Git с веткой `main`, редактором Micro и настроенным автором;
- локальный пакет [`adb-qr`](packages/adb-qr/default.nix) для wireless ADB pairing по QR-коду.

### Игры и запись

Steam включает Remote Play, передачу игр по локальной сети и Protontricks. Пользовательский профиль добавляет Heroic, Legendary, ProtonUp-Qt, Gamescope и Lutris. GameMode включён системно, Vulkan Tools и Mesa Demos доступны для диагностики. OBS Studio использует PipeWire/WirePlumber и XDG portals.

MangoHud имеет полный профиль `MangoHud.conf` и компактный `lite.conf`. Обёртки запускаются так:

```bash
mangohud-full <команда>
mangohud-lite <команда>
```

### Пользовательские приложения и утилиты

Home Manager устанавливает Firefox с русской локалью и пользовательской фиолетовой темой, btop и bottom с темой NIX//UNDERGROUND, Fastfetch, Kate, Spectacle, Discord, AyuGram, qBittorrent, VLC, Strawberry, Darktable, Inkscape, LibreOffice, scrcpy и набор CLI-инструментов мониторинга.

Baloo индексирует домашний каталог, исключая игры, накопители, кэши, Android/Gradle, Steam, виртуальные машины, корзину и `.git` этого репозитория.

## Установка и применение

### Требования

- уже установленная NixOS с UEFI;
- Git и доступ к интернету для получения flake inputs;
- включённые `nix-command` и `flakes` (после первого применения они включаются конфигом);
- проверенные резервные копии важных данных.

### Подготовка для этого же компьютера

```bash
git clone https://github.com/12615az-droid/MyNixOS.git ~/MyNixOS
cd ~/MyNixOS
sudo nixos-rebuild build --flake .#nixos
sudo nixos-rebuild test --flake .#nixos
sudo nixos-rebuild switch --flake .#nixos
```

`build` только собирает систему, `test` активирует её до перезагрузки, а `switch` активирует и делает загрузочной по умолчанию. Перед первым `switch` внимательно просмотрите изменения.

### Перенос на другой компьютер

1. Создайте свежий `/etc/nixos/hardware-configuration.nix` командой `sudo nixos-generate-config` и перенесите релевантные значения в `hosts/nixos/hardware-configuration.nix`.
2. Измените UUID и точки монтирования в `hardware-configuration.nix` и `hardware/disks.nix`.
3. Замените `popov`, UID, домашний каталог, Git identity, SSH-ключ и пути в activation-скриптах.
4. Пересмотрите AMDGPU, OpenRGB, `nct6687`, LACT/overdrive, CoolerControl и Wi-Fi workaround под своё оборудование.
5. Измените фиксированный путь Firefox `6o792e29.default` либо удалите его, чтобы Home Manager не ожидал существующий профиль.
6. Проверьте unfree-пакеты и принятие Android SDK license в соответствии со своими требованиями.
7. Сначала выполните `nixos-rebuild build`, затем `test`, и только после проверки — `switch`.

## Повседневное управление

В Bash определены aliases:

| Команда | Назначение |
| --- | --- |
| `nbuild` | собрать конфигурацию |
| `ntest` | временно активировать конфигурацию |
| `rebuild` | собрать и переключиться |
| `nupdate` | обновить `flake.lock` и переключиться |
| `nclean` | удалить старые поколения и мусор store |
| `wsensors` | обновлять вывод `sensors` каждую секунду |

Без alias используются команды:

```bash
sudo nixos-rebuild build --flake ~/MyNixOS#nixos
sudo nixos-rebuild test --flake ~/MyNixOS#nixos
sudo nixos-rebuild switch --flake ~/MyNixOS#nixos
(cd ~/MyNixOS && nix flake update)
```

Nix автоматически запускает сборку мусора еженедельно, удаляет объекты старше 14 дней и еженедельно оптимизирует store.

## Проверка и устранение проблем

```bash
# Проверить вычисление flake и собрать систему без переключения
nix flake check --no-build
sudo nixos-rebuild build --flake .#nixos

# Посмотреть ошибки текущей загрузки
journalctl -b -p err

# Проверить графику и Vulkan
glxinfo -B
vulkaninfo --summary

# Проверить виртуализацию
virsh -c qemu:///system list --all

# Проверить дополнительные монтирования
systemctl status home-popov-Drives-HDD1.automount
```

Если Home Manager встречает существующий управляемый файл, он сохраняет его с расширением `.hm-backup`. Для libvirt по умолчанию используется `qemu:///system`; каталоги VM создаются в `~/VMs` и на HDD.

## Известные особенности

- В репозитории хранится публичный SSH-ключ и клиентский адрес сервера. Приватных ключей здесь быть не должно.
- `cpu-monitoring.nix` создаёт правила для `intel-rapl:*`, хотя хост настроен как AMD; показания энергопотребления CPU могут быть недоступны без адаптации правила.
- `modules/virtualization/virtiofs.nix` сейчас не импортируется, но `virtiofsd` подключён непосредственно в `modules/virtualization/default.nix`.
- `stateVersion = "26.05"` задаёт совместимость состояния и не должен автоматически меняться при обычном обновлении системы.
- Конфигурация разрешает unfree-пакеты и принимает лицензию Android SDK.

## Лицензия и сторонние проекты

В репозитории пока нет отдельного файла лицензии, поэтому права на повторное использование самой конфигурации явно не предоставлены. `adb-qr` — сторонний MIT-проект [aleixrodriala/adb-qr](https://github.com/aleixrodriala/adb-qr); этот репозиторий содержит только его Nix-упаковку.
