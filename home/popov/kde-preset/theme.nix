{ pkgs }:

{
  accent = "#6A0DAD";

  # Вся папка с обоями.
  # Nix сам положит её в /nix/store.
  wallpaperDir = ../wallpaper;

  # Одиночная картинка для того,
  # что не умеет slideshow.
  wallpaper = ../wallpaper/1.jpg;
}
