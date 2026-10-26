

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    librecad          # 2D-редактор CAD: DWG/DXF (ограничения DWG)
    libredwg          # Конвертация DWG <-> DXF через dwg2dxf / dxf2dwg
    qcad
    # odafileconverter
  ];
}
