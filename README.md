# MyNixOS · Niri + Noctalia / Nix Aurora

Ветка `niri`: NixOS 26.05, Home Manager и прокручиваемый Wayland-десктоп **Niri**.
Тёмный фон, синие, мятные и фиолетовые акценты, скруглённые окна,
градиентная рамка фокуса и собственные обои с логотипом NixOS.

Композиция вдохновлена [rust1xxx/Niri-Noctalia-Dots](https://github.com/rust1xxx/Niri-Noctalia-Dots):
плавающая панель с капсулами, часы и показатели слева, рабочие столы по центру,
медиа-визуализатор и системные кнопки справа. Панель, всплывающие окна,
уведомления и терминал непрозрачны (`opacity = 1`), размытие отключено.
Используется Noctalia **4.7.6** из закреплённого nixpkgs; настройки рассчитаны на v4.

[English](README.en.md)

## Рабочий стол

| Компонент | Реализация |
| --- | --- |
| Вход | greetd + tuigreet, запуск `niri-session` |
| Панель | Noctalia: рабочие столы, часы, CPU/RAM, медиаплеер, визуализатор, раскладка и трей |
| Меню приложений / питание | Noctalia Launcher / Session Menu; отсчёт перед завершением с возможностью отмены |
| Терминал | Kitty, JetBrainsMono Nerd Font, непрозрачный фон |
| Файлы / архивы | Thunar + Xarchiver, автомонтирование и миниатюры |
| Текст / изображения / PDF | Mousepad / Ristretto / Evince; существующий Zed сохранён |
| Уведомления | Noctalia, история и режим «Не беспокоить» |
| Центр управления | Noctalia: сеть, Bluetooth, звук, медиаплеер, системные показатели |
| Блокировка | Swaylock, через 5 минут; экраны гаснут через 10 минут |
| Фон | Noctalia, векторные обои преобразуются в 4K PNG при сборке |
| GTK / значки / курсор | Adwaita-dark с акцентами, Papirus-Dark, Bibata Modern Ice |
| X11-приложения | Автоматическая интеграция xwayland-satellite в Niri |
| Демонстрация экрана | GNOME portal + PipeWire; выбор файлов через GTK portal |

Удалены Plasma, SDDM, plasma-manager (включая lock-запись), KDE Connect,
Baloo и весь старый KDE-пресет. Убраны явно устанавливаемые приложения KDE:
Kate, Spectacle, KSystemStats и Partition Manager; последний заменён GParted.
LibreOffice использует GTK-вариант. Qt-приложения вроде VLC, qBittorrent и
Strawberry сохранены: это самостоятельные программы, не приложения KDE.
Транзитивные библиотеки отдельных программ могут оставаться в Nix store.

Аппаратные настройки AMD, диски, загрузчик, пользователь `popov`, SSH,
VPN, игры, OBS, виртуализация, печать и инструменты разработки сохранены.
Старые пользовательские файлы KDE в домашнем каталоге автоматически не удаляются.

## Переход на ветку

Это конфигурация конкретного компьютера. На другом ПК сначала замените
`hosts/nixos/hardware-configuration.nix` и проверьте модули дисков и пользователя.

В существующем чистом клоне:

```bash
cd ~/MyNixOS
git fetch origin
git switch --track origin/niri
nix flake check
sudo nixos-rebuild build --flake .#nixos
sudo nixos-rebuild boot --flake .#nixos
sudo reboot
```

Если локальная ветка уже существует, используйте `git switch niri`.
Сборка через `boot` применяет новый десктоп при следующей загрузке, не обрывая
текущую графическую сессию. На экране входа введите имя и пароль пользователя.
При неудачной загрузке выберите предыдущее поколение NixOS в загрузчике.
Не удаляйте старые поколения до проверки нового рабочего стола.

Проверено: вычисление полной конфигурации `system.build.toplevel.drvPath`,
сборка проверки `checks.x86_64-linux.niri-config` и валидация сгенерированного
KDL самим Niri 26.04 (`config is valid`). Сгенерированный JSON Noctalia сверен
с ключами настроек версии 4.7.6, проверены непрозрачность и команды блокировки.
Полная сборка всех системных пакетов и запуск графической сессии не выполнялись.

## Клавиши

`Super` — клавиша Windows. Переключение RU/EN — `Alt+Shift`.

| Сочетание | Действие |
| --- | --- |
| Super+Enter / Super+T | Терминал |
| Super+D | Приложения |
| Super+E / Super+B | Файлы / Firefox |
| Super+стрелки | Фокус между окнами |
| Super+Ctrl+стрелки | Перемещение окон / колонок |
| Super+1…4 | main / work / chat / games |
| Super+Ctrl+1…4 | Перенести колонку на рабочий стол |
| Super+PageUp / PageDown | Предыдущий / следующий рабочий стол |
| Super+Shift+Left / Right | Фокус на соседнем мониторе |
| Super+Ctrl+Shift+Left / Right | Перенос колонки на соседний монитор |
| Super+O / Super+Tab | Обзор / предыдущий рабочий стол |
| Super+F / Super+Shift+F | Максимальная ширина / полный экран |
| Super+R / Super+C | Ширина колонки / центрирование |
| Super+V / Super+W | Плавающее окно / вкладки колонки |
| Super+Q / Alt+F4 | Закрыть окно |
| Print / Ctrl+Print / Alt+Print | Область / экран / окно |
| Super+L | Блокировка |
| Super+N | История уведомлений |
| Super+S | Центр управления |
| Super+X | Выбор обоев |
| Super+Shift+S | Снимок области |
| Super+Shift+E | Меню питания |
| Super+Shift+/ | Подсказка по клавишам |

Снимки сохраняются в `~/Pictures/Screenshots`. Клавиши громкости, микрофона,
воспроизведения и яркости настроены; яркость требует поддерживаемой подсветки.

## Настройка

- `modules/desktop/niri.nix` — системная сессия, вход, порталы и интеграция устройств.
- `home/popov/niri/config.kdl` — раскладки, окна, рабочие столы и клавиши.
- `home/popov/niri/palette.nix` — общая палитра панели, окон, терминала, меню и блокировки.
- `home/popov/niri/noctalia-settings.json` — компоновка панели, виджеты, прозрачность и меню.
- `home/popov/niri/noctalia.nix` — установка Noctalia, цветовая схема и системная интеграция.
- `home/popov/niri/default.nix` — GTK, приложения, фон, блокировка и пользовательские службы.
- `home/popov/niri/wallpaper.svg` — исходник обоев; цвета фона редактируются в SVG.

Мониторы используют автоматический режим. Их имена можно узнать через
`niri msg outputs`, затем добавить блоки `output` в `config.kdl` с нужным
масштабом и положением. Разрешение и названия выходов не зафиксированы под чужое оборудование.

Настройки Noctalia управляются Home Manager: изменения в интерфейсе можно
попробовать, но для сохранения перенесите их в `noctalia-settings.json` и пересоберите
систему. Генерация цветов из обоев отключена, поэтому выбранная палитра не меняется.
Swaylock + Swayidle отвечают за блокировку; дублирующий idle-менеджер Noctalia отключён.

## Источники

- [Niri: документация](https://niri-wm.github.io/niri/)
- [Модуль Niri из закреплённого nixpkgs](https://github.com/NixOS/nixpkgs/blob/5e2305d577ca00acbba631b05cb1094d172b29f3/nixos/modules/programs/wayland/niri.nix)
- [Home Manager](https://nix-community.github.io/home-manager/)
- [Noctalia v4](https://docs.noctalia.dev/noctalia-shell-legacy/)
- [Конфигурация-образец](https://github.com/rust1xxx/Niri-Noctalia-Dots)
- [adb-qr — исходный проект](https://github.com/aleixrodriala/adb-qr)
