{ config, ... }:

let
  peerKey = "ndqLotrwUrHYdOVkifoIFexOmRYwY8z0GdYI0ZSEXHM=";
in
{
  networking.networkmanager.ensureProfiles = {
    environmentFiles = [
      config.age.secrets.vpn-nm-env.path
    ];

    profiles.popovnixos-pc = {
      connection = {
        id = "popovnixos-pc";
        uuid = "fb07bd51-31e5-4e1c-8dd3-1bc6bd4155e6";
        type = "wireguard";
        "interface-name" = "popovnixos-pc";

        # Главное: VPN не включается сам.
        # Включаешь его через KDE.
        autoconnect = false;
      };

      wireguard = {
        "private-key" = "$WG_PRIVATE_KEY";
        "listen-port" = 42800;
        mtu = 1420;
        "peer-routes" = true;
      };

      "wireguard-peer.${peerKey}" = {
        endpoint = "83.171.227.174:51820";
        "allowed-ips" = "0.0.0.0/0;";
        "persistent-keepalive" = 25;
      };

      ipv4 = {
        method = "manual";
        address1 = "10.66.66.5/32";
        dns = "10.66.66.1;";
      };

      ipv6 = {
        method = "disabled";
      };
    };
  };
}
