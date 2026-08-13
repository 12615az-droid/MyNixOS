{
  lib,
  fetchPypi,
  python3Packages,
  androidenv,
}:

let
  platformTools = androidenv.androidPkgs.platform-tools;
in

python3Packages.buildPythonApplication rec {
  pname = "adb-qr";
  version = "0.1.0";

  pyproject = true;

  src = fetchPypi {
    pname = "adb_qr";
    inherit version;
    hash = "sha256-YJji9PIudZDdV7UGqgXY4rBRLINTITLHbRlSflpO6fg=";
  };

  build-system = with python3Packages; [
    hatchling
  ];

  dependencies = with python3Packages; [
    qrcode
  ];

  makeWrapperArgs = [
    "--prefix"
    "PATH"
    ":"
    (lib.makeBinPath [ platformTools ])
  ];

  doCheck = false;

  pythonImportsCheck = [
    "adb_qr"
  ];

  meta = {
    description = "Pair Android devices for wireless ADB using a QR code";
    homepage = "https://github.com/aleixrodriala/adb-qr";
    license = lib.licenses.mit;
    mainProgram = "adb-qr";
  };
}
