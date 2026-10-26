{ lib, rustPlatform, makeWrapper, makeDesktopItem, libGL, libxkbcommon,
  wayland, libx11, libxcursor, libxi, libxrandr, util-linux, smartmontools, src }:

let
  cargoToml = builtins.fromTOML (builtins.readFile "${src}/Cargo.toml");
  desktopItem = makeDesktopItem {
    name = "olhm";
    desktopName = "OLHM";
    comment = "Open Linux Hardware Monitor";
    exec = "olhm gui";
    icon = "utilities-system-monitor";
    categories = [ "X-Myprodgect" ];
    terminal = false;
  };
in
rustPlatform.buildRustPackage {
  pname = cargoToml.package.name;
  version = cargoToml.package.version;
  src = lib.cleanSourceWith {
    inherit src;
    filter = path: type:
      lib.cleanSourceFilter path type
      && !(builtins.elem (builtins.baseNameOf path) [ "target" "dist" "result" ]);
  };
  cargoLock.lockFile = "${src}/Cargo.lock";

  buildFeatures = [ "gui" ];
  nativeBuildInputs = [ makeWrapper ];

  postInstall = ''
    wrapProgram $out/bin/olhm \
      --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [
        libGL libxkbcommon wayland libx11 libxcursor libxi libxrandr
      ]} \
      --prefix PATH : ${lib.makeBinPath [ util-linux smartmontools ]}
    install -Dm644 ${desktopItem}/share/applications/olhm.desktop \
      $out/share/applications/olhm.desktop
  '';

  meta = {
    description = "Open Linux Hardware Monitor with CPU and RAM GUI";
    mainProgram = "olhm";
    platforms = lib.platforms.linux;
  };
}
