{ ... }:

{
  xdg.configFile."baloofilerc" = {
    force = true;

    text = ''
      [Basic Settings]
      Indexing-Enabled=true

      [General]
      dbVersion=2
      only basic indexing=true
      folders[$e]=$HOME/
      exclude folders[$e]=$HOME/Games/,$HOME/Drives/,$HOME/.cache/,$HOME/.gradle/,$HOME/.android/,$HOME/Android/,$HOME/.local/share/Steam/,$HOME/.steam/,$HOME/MyNixOS/.git/,$HOME/.local/share/Trash/,$HOME/VMs/
    '';
  };
}
