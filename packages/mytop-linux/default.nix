{ lib, rustPlatform, pkg-config, wrapGAppsHook3, gtk3, webkitgtk_4_1, src }:

let
  cargoToml = builtins.fromTOML (builtins.readFile "${src}/Cargo.toml");
in
rustPlatform.buildRustPackage {
  pname = cargoToml.package.name;
  version = cargoToml.package.version;
  src = lib.cleanSourceWith {
    inherit src;
    filter = path: type:
      lib.cleanSourceFilter path type
      && !(builtins.elem (builtins.baseNameOf path) [ "target" "result" ]);
  };
  cargoLock.lockFile = "${src}/Cargo.lock";

  nativeBuildInputs = [ pkg-config wrapGAppsHook3 ];
  buildInputs = [ gtk3 webkitgtk_4_1 ];

  postInstall = ''
    install -Dm644 packaging/io.github.mytop.Linux.desktop \
      $out/share/applications/io.github.mytop.Linux.desktop
    substituteInPlace $out/share/applications/io.github.mytop.Linux.desktop \
      --replace-fail 'Categories=Game;Utility;' 'Categories=X-Myprodgect;'
    install -Dm644 ui/icon.png $out/share/icons/hicolor/192x192/apps/mytop-linux.png
  '';

  meta = {
    description = "Offline game collection for Linux";
    mainProgram = "mytop-linux";
    platforms = [ "x86_64-linux" ];
  };
}
