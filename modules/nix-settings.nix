{ ... }:

{
  nixpkgs.config.allowUnfree = true;


  programs.nix-ld.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Автоматическая очистка старых поколений и мусора Nix.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # Оптимизация Nix Store: одинаковые файлы заменяются ссылками.
  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };
}
