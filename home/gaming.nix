{ pkgs, ... }:

{

programs.mangohud = {
  enable = true;
  settings = {
    fps = true;
    frametime = true;
    cpu_temp = true;
    gpu_temp = true;
    vram = true;
    ram = true;
    position = "top-left";
    font_size = 18;
    background_alpha = 0.3;
  };
};
  home.packages = with pkgs; [
    # Epic / GOG / Amazon
    heroic
    legendary-gl

    # Общие игровые утилиты
    protonup-qt

    gamescope

    # Дополнительный лаунчер, пригодится для нестандартных игр
    lutris
  ];
}
