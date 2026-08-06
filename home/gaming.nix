{ pkgs, ... }:

{





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
