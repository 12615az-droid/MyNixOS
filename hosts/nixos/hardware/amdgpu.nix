{ config, ... }:

{


  # Использовать драйвер NVIDIA.
  # Название xserver историческое — Wayland продолжает работать.
  services.xserver.videoDrivers = [ "amdgpu" ];



}
