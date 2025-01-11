{ ... }:

{
  # System-wide configuration
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  # System-wide virtualization settings
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };

  # If you're using UEFI
  virtualisation.libvirtd.qemu = {
    ovmf.enable = true;
    swtpm.enable = true;
  };
}

