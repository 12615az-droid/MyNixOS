{ config, pkgs, lib, ... }:

{
  # === Только Intel UHD 730 ===
  services.xserver.videoDrivers = [ "modesetting" ];

  boot.initrd.kernelModules = [ "i915" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libvdpau-va-gl
      intel-compute-runtime
    ];
  };

  # === IOMMU ===
  boot.kernelParams = [
    "intel_iommu=on"
    "iommu=pt"
  ];

  # === VFIO: биндим GTX 1060 ===
  boot.initrd.kernelModules = [ "vfio" "vfio_pci" "vfio_iommu_type1" ];
  boot.kernelModules = [ "kvm-intel" ];

  boot.extraModprobeConfig = ''
    options vfio-pci ids=10de:1c02,10de:10f1
    options vfio-pci disable_vga=1
  '';

  # === Чёрный список NVIDIA ===
  boot.blacklistedKernelModules = [
    "nouveau"
    "nvidia"
    "nvidia_drm"
    "nvidia_modeset"
    "nvidia_uvm"
  ];


}
