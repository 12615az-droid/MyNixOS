{ config, lib, pkgs, ... }:

let
  version = "0.9.5";
  tag = "v${version}";
  archive = "HPRv${version}-Linux.tar.xz";
  releaseUrl = "https://github.com/plexescor/HPR/releases/download/${tag}/${archive}";
in
{
  home.packages = with pkgs; [
    curl
    gnutar
    xz
    dbus
    kdePackages.qttools
  ];

  home.activation.installHpr = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    set -eu

    install_dir="$HOME/.local/lib/hpr"
    binary="$install_dir/HPR"
    version_file="$install_dir/.version"

    if [ ! -x "$binary" ] || [ ! -f "$version_file" ] || [ "$(cat "$version_file")" != "${version}" ]; then
      tmp_dir="$(${pkgs.coreutils}/bin/mktemp -d)"
      trap '${pkgs.coreutils}/bin/rm -rf "$tmp_dir"' EXIT

      ${pkgs.curl}/bin/curl --fail --location --retry 3 \
        --output "$tmp_dir/${archive}" \
        "${releaseUrl}"

      ${pkgs.gnutar}/bin/tar -xJf "$tmp_dir/${archive}" -C "$tmp_dir"
      source_binary="$(${pkgs.findutils}/bin/find "$tmp_dir" -type f -name HPR -print -quit)"

      if [ -z "$source_binary" ]; then
        echo "HPR binary was not found in ${archive}" >&2
        exit 1
      fi

      ${pkgs.coreutils}/bin/mkdir -p "$install_dir" "$HOME/.local/bin"
      ${pkgs.coreutils}/bin/install -m 0755 "$source_binary" "$binary"
      ${pkgs.coreutils}/bin/printf '%s\n' "${version}" > "$version_file"

      source_dir="$(${pkgs.coreutils}/bin/dirname "$source_binary")"
      for item in aliases.csv tabAliases.csv projectAliases.csv config.csv ui; do
        if [ -e "$source_dir/$item" ] && [ ! -e "$HOME/.config/HPR/$item" ]; then
          ${pkgs.coreutils}/bin/mkdir -p "$HOME/.config/HPR"
          ${pkgs.coreutils}/bin/cp -R "$source_dir/$item" "$HOME/.config/HPR/$item"
        elif [ -e "$source_dir/shippedWithBinary/$item" ] && [ ! -e "$HOME/.config/HPR/$item" ]; then
          ${pkgs.coreutils}/bin/mkdir -p "$HOME/.config/HPR"
          ${pkgs.coreutils}/bin/cp -R "$source_dir/shippedWithBinary/$item" "$HOME/.config/HPR/$item"
        fi
      done
    fi

    ${pkgs.coreutils}/bin/mkdir -p "$HOME/.local/bin" "$HOME/.local/share/HPR"
    ${pkgs.coreutils}/bin/ln -sfn "$binary" "$HOME/.local/bin/HPR"
  '';

  xdg.desktopEntries.hpr = {
    name = "HPR";
    genericName = "Activity tracker";
    comment = "Local activity tracker for KDE Plasma Wayland";
    exec = "${config.home.homeDirectory}/.local/bin/HPR";
    terminal = false;
    categories = [ "Utility" ];
    startupNotify = false;
  };

  xdg.configFile."autostart/hpr.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=HPR
    Comment=Local activity tracker for KDE Plasma Wayland
    Exec=${config.home.homeDirectory}/.local/bin/HPR
    Terminal=false
    X-KDE-autostart-after=panel
    X-KDE-StartupNotify=false
  '';
}
