{ ... }:

{
  programs.plasma.input.keyboard = {
    layouts = [
      {
        layout = "us";
        displayName = "EN";
      }
      {
        layout = "ru";
        displayName = "RU";
      }
    ];

    switchingPolicy = "global";

    # Win + Space, как в Windows
    options = [
      "grp:win_space_toggle"
    ];
  };
}
