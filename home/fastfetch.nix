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
          type = "title";
        }

        {
          type = "custom";
          format = "────────────────────────────────";
          outputColor = "blue";
        }

        {
          type = "os";
          key = "OS";
          keyColor = "cyan";
        }

        {
          type = "host";
          key = "Host";
          keyColor = "blue";
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

        {
          type = "monitor";
          key = "Monitor {index}";
          keyColor = "cyan";
          format = "{width}x{height} @ {refresh-rate} Hz";
        }

        "break"

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
