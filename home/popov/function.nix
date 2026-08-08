{ ... }:

{
  programs.bash = {
    enable = true;

    initExtra = ''
      rebuildVPN() {
        local server="$1"
        local ip="$2"
        local configDir="$HOME/NixOS-vpnServer"

        if [[ -z "$server" || -z "$ip" ]]; then
          echo "Использование: rebuildVPN <имя-сервера> <IP>"
          return 1
        fi

        nixos-rebuild switch \
          --flake "$configDir#$server" \
          --target-host "admin@$ip" \
          --sudo
      }
    '';
  };
}
