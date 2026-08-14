{
  pkgs,
  ...
}:
{
  # Virtualization settings
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
  };
}
