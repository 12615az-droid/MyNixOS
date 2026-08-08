{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # IDE / editors
    vscode
    android-studio

    # Java / Android development
    jdk17
    kotlin
    gradle
    android-tools
  ];
}
