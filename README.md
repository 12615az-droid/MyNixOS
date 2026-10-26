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
│   ├── apps/                         # приложения и общий набор пакетов
│   ├── development/                  # инструменты и редакторы разработки
│   ├── desktop/                      # Plasma, Baloo и оформление
│   ├── gaming/                       # игры и MangoHud
│   ├── terminal/                     # shell, SSH и терминальный мониторинг
│   ├── wallpaper/                    # набор обоев
│   └── */default.nix                 # точки входа тематических групп
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
- OpenRGB запускается системным сервисом и загружает профиль `nonrgb`, который отключает подсветку модулей Kingston Fury DDR5.

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

`home/popov/desktop/kde-preset/` декларативно задаёт:

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

### Приложения вне nixpkgs

Собственные приложения и сторонние утилиты, которых нет в основном наборе `nixpkgs`, всё равно подключаются через Nix. Исходный код берётся из локального каталога, GitHub или другого реестра, а файл в `packages/` описывает его сборку и установку. После этого пакет добавляется в `home.packages` как любой штатный пакет.

Текущий поток для собственных приложений выглядит так:

```text
flake.nix: input с исходниками
└── extraSpecialArgs
    └── home/popov/development/myprodgect.nix
        └── pkgs.callPackage packages/<имя> { src = <input>.outPath; }
            └── home.packages
                └── профиль пользователя и меню Plasma
```

Сейчас этим способом подключены два локальных проекта:

| Приложение | Источник | Описание сборки |
| --- | --- | --- |
| `mytop-linux` | `/home/popov/MyProject/MyTopLinux` | `packages/mytop-linux/default.nix` |
| `olhm` | `/home/popov/MyProject/olhm` | `packages/olhm/default.nix` |

В [`flake.nix`](flake.nix) `mytop-linux` объявлен как flake-проект, поэтому его вход `nixpkgs` следует за основной версией `nixpkgs`. У `olhm` нет собственного `flake.nix`, поэтому для него задано `flake = false`:

```nix
mytop-linux = {
  url = "path:/home/popov/MyProject/MyTopLinux";
  inputs.nixpkgs.follows = "nixpkgs";
};

olhm = {
  url = "path:/home/popov/MyProject/olhm";
  flake = false;
};
```

Оба входа передаются модулям Home Manager через `extraSpecialArgs`. Модуль [`home/popov/development/myprodgect.nix`](home/popov/development/myprodgect.nix) получает их как аргументы `mytop-linux` и `olhm`, а затем вызывает локальные описания пакетов:

```nix
home.packages = [
  (pkgs.callPackage ../../../packages/mytop-linux { src = mytop-linux.outPath; })
  (pkgs.callPackage ../../../packages/olhm { src = olhm.outPath; })
];
```

Здесь `outPath` — сохранённый Nix снимок исходников выбранного input. `callPackage` читает аргументы функции из `packages/<имя>/default.nix`, автоматически подставляет библиотеки и инструменты из `pkgs`, а `src` получает явно. Рабочие каталоги `~/MyProject/...` во время обычного запуска больше не используются.

#### Что происходит при сборке

1. Nix читает абсолютный `path:` из `flake.nix` и сверяет снимок каталога с хешем в `flake.lock`.
2. `lib.cleanSourceWith` копирует исходники в Nix store, исключая результаты предыдущих локальных сборок: `target`, `result`, а для OLHM также `dist`.
3. `rustPlatform.buildRustPackage` читает имя и версию из `Cargo.toml`, проверяет `Cargo.lock` и собирает проект в изолированном окружении Nix.
4. Результат записывается в новый неизменяемый каталог вида `/nix/store/<hash>-<имя>-<версия>/`. В нём находятся `bin/`, desktop-файл, значок и необходимые обёртки.
5. Home Manager создаёт общий пользовательский профиль и ссылки из `/etc/profiles/per-user/popov/` на выбранные результаты в Nix store. Старый результат остаётся частью предыдущего поколения и может быть возвращён откатом.

Исходный код в `~/MyProject` является входом сборки, а не местом запуска. Поэтому сохранение файла `.rs`, новый локальный `cargo build` или замена `target/debug/<программа>` сами по себе не меняют приложение в меню Plasma. Требуется создать новый снимок input, собрать конфигурацию и активировать новое поколение.

Проверить, какой результат сейчас запускается, можно так:

```bash
command -v mytop-linux
readlink -f "$(command -v mytop-linux)"

command -v olhm
readlink -f "$(command -v olhm)"
```

Первая команда обычно показывает путь пользовательского профиля, а `readlink -f` — конкретный каталог сборки в `/nix/store` с версией программы.

#### Как запускается MyTop Linux

Описание [`packages/mytop-linux/default.nix`](packages/mytop-linux/default.nix) собирает бинарник `mytop-linux` с GTK 3 и WebKitGTK. `wrapGAppsHook3` создаёт обёртку, которая перед запуском добавляет пути к GTK-схемам, GIO-модулям и ресурсам приложения.

Во время сборки происходят два дополнительных действия:

- desktop-файл проекта устанавливается как `$out/share/applications/io.github.mytop.Linux.desktop`;
- значок устанавливается как `$out/share/icons/hicolor/192x192/apps/mytop-linux.png`, а категория desktop-файла заменяется на `X-Myprodgect`.

После активации Home Manager Plasma видит desktop-файл через пользовательский профиль. Нажатие на «MyTop» выполняет указанную в нём команду:

```ini
Exec=mytop-linux
```

Эту же программу можно запустить из терминала командой `mytop-linux`. Shell находит её в `/etc/profiles/per-user/popov/bin`, ссылка приводит к обёртке в Nix store, а та запускает настоящий Rust-бинарник с подготовленным окружением GTK.

HTML, CSS, JavaScript, переводы и значок интерфейса встраиваются в бинарник во время компиляции через `include_str!` и `include_bytes!`. При запуске MyTop не читает интерфейс из `~/MyProject/MyTopLinux/ui`, поэтому правка этих файлов также требует новой сборки.

Пользовательские данные хранятся отдельно от программы. По умолчанию это каталог `$XDG_DATA_HOME/mytop-linux`, обычно `~/.local/share/mytop-linux/`:

```text
~/.local/share/mytop-linux/
├── mytop.sqlite3       # игры и настройки
├── covers/             # импортированные обложки
└── custom-font.bin     # импортированный шрифт, если он задан
```

Новая Nix-сборка заменяет код программы в профиле, но продолжает использовать этот каталог данных.

#### Как запускается OLHM

Описание [`packages/olhm/default.nix`](packages/olhm/default.nix) собирает `olhm` с feature `gui`. Desktop-файл создаётся самой Nix-конфигурацией и устанавливается как `$out/share/applications/olhm.desktop`. Его команда запуска:

```ini
Exec=olhm gui
```

Поэтому пункт «OLHM» в Plasma открывает графический интерфейс с начальной вкладкой CPU. Из терминала доступны тот же GUI и консольные режимы:

```bash
olhm gui
olhm gui ram
olhm gui storage
olhm info cpu
olhm snapshot ram
olhm monitor storage --interval 2
olhm collect cpu --format json
```

`wrapProgram` помещает перед настоящим бинарником shell-обёртку. Она добавляет в `LD_LIBRARY_PATH` OpenGL, Wayland и X11-библиотеки, а в `PATH` — `lsblk` из `util-linux` и `smartctl` из `smartmontools`. После подготовки окружения обёртка выполняет скрытый бинарник `.olhm-wrapped` из того же каталога Nix store.

OLHM получает показатели непосредственно во время работы: читает доступные интерфейсы `/proc` и `/sys`, а для накопителей вызывает зафиксированные Nix-версии `lsblk` и `smartctl`. Отдельная рабочая копия проекта для этого не нужна. Часть SMART-показателей может быть недоступна, если у пользователя нет разрешения на чтение устройства; остальные доступные показатели продолжают отображаться.

OLHM не хранит свою базу рядом с исходниками: после запуска он опрашивает оборудование и показывает текущие данные. Закрытие окна завершает процесс мониторинга.

#### Как Plasma находит оба приложения

[`home/popov/development/myprodgect.nix`](home/popov/development/myprodgect.nix) создаёт описание раздела меню `myprodgect` и правило, включающее desktop-файлы с категорией `X-Myprodgect`. После активации цепочка запуска выглядит так:

```text
пункт в меню Plasma
└── desktop-файл из пользовательского профиля
    ├── Exec=mytop-linux
    │   └── GTK-обёртка → бинарник MyTop в /nix/store
    └── Exec=olhm gui
        └── shell-обёртка → бинарник OLHM в /nix/store
```

Удаление или переименование каталога `~/MyProject` после успешной активации обычно не мешает уже установленной версии запускаться: её снимок и бинарник находятся в Nix store. Однако следующая оценка или пересборка конфигурации завершится ошибкой, потому что `flake.nix` больше не найдёт локальный input.

После изменения локального проекта нужно обновить только его запись в `flake.lock`, проверить конфигурацию и применить её:

```bash
cd ~/MyNixOS
nix flake update mytop-linux   # либо olhm
nbuild
rebuild
```

`nix flake update` записывает новый хеш локального снимка в `flake.lock`. `nbuild` проверяет, что вся конфигурация собирается, но не меняет активный профиль. `rebuild` выполняет `nixos-rebuild switch`: активирует новое поколение, после чего новые команды и пункты меню указывают на свежие пути в Nix store. Уже открытый процесс продолжает выполнять старый бинарник до перезапуска приложения.

Абсолютные `path:` зависят от расположения каталогов на этом компьютере. Для сборки прямо из GitHub достаточно заменить только URL источника; остальная схема остаётся прежней:

```nix
# Репозиторий с flake.nix
mytop-linux = {
  url = "github:OWNER/MyTopLinux";
  inputs.nixpkgs.follows = "nixpkgs";
};

# Обычный репозиторий без flake.nix
olhm = {
  url = "github:OWNER/olhm";
  flake = false;
};
```

Конкретный коммит фиксируется в `flake.lock`, поэтому повторная сборка использует те же исходники. Команда `nix flake update mytop-linux` или `nix flake update olhm` подтягивает новую ревизию только выбранного приложения. Для привязки к ветке или тегу можно использовать URL вида `github:OWNER/REPO/BRANCH-OR-TAG`.

Чтобы добавить ещё одну собственную программу или утилиту:

1. Добавьте её источник в `inputs` файла `flake.nix`; для репозитория без flake укажите `flake = false`.
2. Добавьте имя input в аргументы `outputs` и передайте его через `home-manager.extraSpecialArgs`.
3. Создайте `packages/<имя>/default.nix` с подходящей функцией сборки: например, `rustPlatform.buildRustPackage`, `buildGoModule` или `python3Packages.buildPythonApplication`.
4. Подключите derivation через `pkgs.callPackage` и добавьте результат в `home.packages`.
5. Если приложение графическое, установите его `.desktop` и значок в `$out/share`; для раздела собственных программ задайте категорию `X-Myprodgect`.
6. Обновите нужный input, выполните `nbuild`, а после успешной проверки — `rebuild`.

`adb-qr` показывает ещё один вариант: [`packages/adb-qr/default.nix`](packages/adb-qr/default.nix) получает исходный архив из PyPI по имени, версии и SHA-256, добавляет Python-зависимости и `adb` в `PATH`, после чего подключается из `home/popov/development/development.nix`.

Для уже собранных сторонних программ включены дополнительные способы запуска:

- `programs.appimage.enable` и `binfmt` позволяют запускать скачанные AppImage;
- `services.flatpak.enable` включает Flatpak, а сами приложения устанавливаются и обновляются командами Flatpak;
- `programs.nix-ld.enable` помогает запускать некоторые динамически скомпонованные Linux-бинарники, ожидающие стандартные пути библиотек.

Эти способы не добавляют конкретное приложение в конфигурацию автоматически. Для воспроизводимой установки предпочтительнее отдельный derivation с зафиксированными версией и хешем. Пакеты `.deb` напрямую в систему не устанавливаются: их содержимое нужно упаковать в derivation либо использовать уже готовое описание из `nixpkgs`. Поэтому `cisco-packet-tracer_9` сейчас закомментирован до добавления требуемого установочного файла в Nix store.

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
