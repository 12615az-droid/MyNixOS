{ ... }:

{
  programs.plasma.powerdevil = {
    AC = {
      powerButtonAction = "showLogoutScreen";

      autoSuspend = {
        action = "nothing";
        idleTimeout = null;
      };

      turnOffDisplay = {
        idleTimeout = null;
      };
    };
  };
}
