{ pkgs, ... }:

{
  programs.fastfetch = {
    enable = true;
    package = pkgs.fastfetch;

    settings = {
      logo = {
        type = "builtin";
        source = "nixos";

        padding = {
          top = 1;
          right = 4;
        };
      };

      display = {
        separator = " : ";

        key = {
          width = 11;
        };

        size = {
          binaryPrefix = "iec";
        };
      };

      modules = [
        {
          type = "custom";
          format = "──────────── USER ─────────────";
          outputColor = "blue";
        }

        {
          type = "title";
        }

        {
          type = "custom";
          key = "GitHub";
          format = "https://github.com/12615az-droid";
          keyColor = "cyan";
        }

        "break"

        {
          type = "custom";
          format = "───────────── OS ──────────────";
          outputColor = "blue";
        }

        {
          type = "os";
          key = "OS";
          keyColor = "cyan";
        }

        {
          type = "kernel";
          key = "Kernel";
          keyColor = "magenta";
        }

        {
          type = "uptime";
          key = "Uptime";
          keyColor = "cyan";
        }

        {
          type = "packages";
          key = "Packages";
          keyColor = "blue";
        }

        {
          type = "de";
          key = "Desktop";
          keyColor = "magenta";
        }

        {
          type = "wm";
          key = "Session";
          keyColor = "blue";
        }

        "break"

        {
          type = "custom";
          format = "────────── HARDWARE ───────────";
          outputColor = "blue";
        }

        {
          type = "host";
          key = "Host";
          keyColor = "blue";
        }

        {
          type = "monitor";
          key = "Monitor {index}";
          keyColor = "cyan";
          format = "{width}x{height} @ {refresh-rate} Hz";
        }

        {
          type = "cpu";
          key = "CPU";
          keyColor = "cyan";
        }

        {
          type = "gpu";
          key = "GPU";
          keyColor = "blue";
          format = "{name}";
        }

        {
          type = "memory";
          key = "Memory";
          keyColor = "magenta";
        }



        {
          type = "disk";
          key = "Disk";
          keyColor = "cyan";
        }
      ];
    };
  };
}
