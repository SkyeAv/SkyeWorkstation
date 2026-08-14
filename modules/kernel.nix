{
  pkgs,
  inputs,
  config,
  ...
}:
{
  # Kernel, boot, hardware, and OS configuration
  nixpkgs = {
    hostPlatform = "x86_64-linux";
    overlays = [
      inputs.neovim-nightly-overlay.overlays.default
      inputs.nix-cachyos-kernel.overlays.pinned
    ];
    # Allow unfree packages
    config = {
      allowUnfree = true;
      cudaSupport = true;
      # Allow insecure for electron bug
      permittedInsecurePackages = [ "electron-39.8.10" ];
    };
  };
  boot = {
    loader = {
      timeout = 1;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    # Catchy-os kernel
    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-lts-lto-zen4;
    kernelParams = [
      "rd.systemd.show_status=false"
      "transparent_hugepage=always"
      "numa_balancing=disable"
      "acpi_backlight=native"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "amd_pstate=active"
      "loglevel=3"
      "nowatchdog"
      "splash"
      "quiet"
    ];
    kernelModules = [
      "snd-seq-midi"
      "asus_wmi"
      "uvcvideo"
      "k10temp"
      "nct6775"
      "uinput"
      "btusb"
      "jc42"
    ];
    kernel.sysctl = {
      "vm.nr_overcommit_hugepages" = 256;
      "vm.compaction_proactiveness" = 0;
      "vm.dirty_background_ratio" = 5;
      "vm.vfs_cache_pressure" = 50;
      "vm.overcommit_memory" = 1;
      "vm.nr_hugepages" = 512;
      "vm.page-cluster" = 3;
      "vm.dirty_ratio" = 15;
      "vm.swappiness" = 10;
    };
    extraModprobeConfig = ''
      options nvidia NVreg_RegistryDwords="PeerMappingOverride=1"
      options nvidia NVreg_UsePageAttributeTable=1
      options nvidia NVreg_EnableGpuFirmware=1
      options nvidia_drm modeset=1 fbdev=1
    '';
    # Special boot settings
    plymouth.enable = true;
    consoleLogLevel = 0;
    initrd.verbose = false;
  };
  # Timezone and location settings
  time.timeZone = "America/Los_Angeles";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };
  # Hardware configuration
  hardware = {
    enableAllFirmware = true;
    steam-hardware.enable = true;
    acpilight.enable = true;
    # Bluetooth settings
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
        };
        Policy.AutoEnable = true;
      };
    };
    # General graphics settings
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        nvidia-vaapi-driver
      ];
    };
    # Nvidia settings
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      prime = {
        sync.enable = true;
        nvidiaBusId = "PCI:100:0:0";
        amdgpuBusId = "PCI:101:0:0";
      };
      powerManagement.finegrained = false;
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
  };
  # Zram
  zramSwap = {
    enable = true;
    algorithm = "l4z";
    memoryPercent = 25;
  };
}
