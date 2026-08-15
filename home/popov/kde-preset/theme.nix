{ pkgs }:

let
  wallpapers = ~/MyNixOS/home/popov/wallpapers;
in
{
  accent = "#6A0DAD";

  # Папка со всеми твоими обоями
  wallpaperDir = wallpapers;

  # Одна картинка остаётся для мест, где требуется именно файл,
  # например для SDDM
  wallpaper = "${wallpapers}/01.*";
}
