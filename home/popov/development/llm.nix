
# Home Manager: local AI on AMD GPU via Vulkan (Mesa RADV).
# No background services; run manually when needed.
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    llama-cpp-vulkan            # Text generation
    stable-diffusion-cpp-vulkan # Image generation
    vulkan-tools                # GPU/Vulkan diagnostics
  ];
}
