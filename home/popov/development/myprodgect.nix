{ pkgs, mytop-linux, olhm, ... }:

{
  home.packages = [
    (pkgs.callPackage ../../../packages/mytop-linux { src = mytop-linux.outPath; })
    (pkgs.callPackage ../../../packages/olhm { src = olhm.outPath; })
  ];

  xdg.dataFile."desktop-directories/myprodgect.directory".text = ''
    [Desktop Entry]
    Type=Directory
    Name=myprodgect
    Icon=applications-development
  '';

  xdg.configFile."menus/applications-merged/myprodgect.menu".text = ''
    <!DOCTYPE Menu PUBLIC "-//freedesktop//DTD Menu 1.0//EN"
      "http://www.freedesktop.org/standards/menu-spec/1.0/menu.dtd">
    <Menu>
      <Name>Applications</Name>
      <Menu>
        <Name>myprodgect</Name>
        <Directory>myprodgect.directory</Directory>
        <Include>
          <Category>X-Myprodgect</Category>
        </Include>
      </Menu>
    </Menu>
  '';
}
