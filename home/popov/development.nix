{ pkgs, ... }:

let
  adbQr = pkgs.callPackage ../../packages/adb-qr { };
in
{
  home.packages = with pkgs; [
    android-studio

    jdk17
    kotlin
    gradle

    codex

    androidenv.androidPkgs.platform-tools

    adbQr
  ];
}
