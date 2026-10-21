
{ pkgs, ... }:

{
  services.pulseaudio.enable = false;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  systemd.user.services.fix-headphones = {
    description = "Auto select front panel headphones";

    wantedBy = [ "default.target" ];

    after = [
      "pipewire.service"
      "pipewire-pulse.service"
      "wireplumber.service"
    ];

    wants = [
      "pipewire-pulse.socket"
      "wireplumber.service"
    ];

    serviceConfig = {
      Type = "oneshot";

      ExecStart = pkgs.writeShellScript "fix-headphones" ''
        PACTL="${pkgs.pulseaudio}/bin/pactl"
        JQ="${pkgs.jq}/bin/jq"

        for i in $(seq 1 20); do
          SINKS=$($PACTL -f json list sinks 2>/dev/null) || {
            sleep 1
            continue
          }

          HEADPHONE_SINK=$(printf '%s\n' "$SINKS" |
            $JQ -r '
              .[] |
              select(
                any(.ports[]?;
                  .name == "analog-output-headphones"
                  and .availability == "yes"
                )
              ) |
              .name
            ' | head -n 1)

          if [ -n "$HEADPHONE_SINK" ]; then
            $PACTL set-sink-port \
              "$HEADPHONE_SINK" \
              analog-output-headphones
          fi

          exit 0
        done

        exit 1
      '';
    };
  };
}
