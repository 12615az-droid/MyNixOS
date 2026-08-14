{ pkgs }:

{
  accent = "#6A0DAD";

  wallpaper =
    "${pkgs.kdePackages.plasma-workspace-wallpapers}"
    + "/share/wallpapers/ScarletTree/contents/images/5120x2880.png";
}
