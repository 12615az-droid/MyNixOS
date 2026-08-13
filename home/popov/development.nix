{ pkgs, ... }:

let
  adbQr = pkgs.callPackage ../../packages/adb-qr { };
in
{
  home.packages = with pkgs; [
    vscode
    android-studio

    jdk17
    kotlin
    gradle

    androidenv.androidPkgs.platform-tools

    adbQr
  ];
}
