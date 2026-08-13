{ ... }:

{
  boot = {
    loader = {
      systemd-boot = {
        configurationLimit = 5;
        editor = false;
        enable = true;
      };

      efi = {
        canTouchEfiVariables = true;
      };

      timeout = 3;
    };
  };
}
