{
  pkgs,
  ...
}:
{
  # Service and daemon settings
  services = {
    # Automatic nicing
    ananicy = {
      enable = true;
      package = pkgs.ananicy-cpp;
      rulesProvider = pkgs.ananicy-rules-cachyos;
    };
    # X11 compatability
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      videoDrivers = [
        "amdgpu"
        "nvidia"
      ];
    };
    # Plasma services
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    # Printing
    printing.enable = true;
    # Audio settings
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
    # Touchpad support
    libinput.enable = true;
    # EarlyOOM
    earlyoom = {
      enable = true;
      freeMemThreshold = 5;
      freeSwapThreshold = 10;
    };
    # Labtop and SSD
    asusd.enable = true;
    supergfxd.enable = true;
    fstrim.enable = true;
    # Ollama
    ollama = {
      enable = true;
      package = pkgs.ollama-vulkan;
      environmentVariables = {
        OLLAMA_KV_CACHE_TYPE = "q8_0";
        OLLAMA_FLASH_ATTENTION = "1";
      };
    };
    # Fcrontab
    fcron = {
      enable = true;
      systab = ''
        # PLACEHOLDER UNTIL HOME SERVER SETUP
      '';
    };
    # SSH
    openssh.enable = true;
    # Power profiles daemon
    power-profiles-daemon.enable = true;
    # Udev rules
    udev.packages = with pkgs; [
      mixxx
    ];
  };
  # Systemd
  systemd = {
    services = {
      NetworkManager-wait-online.enable = false;
    };
    # User services
    user = {
      services = {
        # Kache content-addressed build cache daemon (cargo-installed; not in nixpkgs)
        kache = {
          description = "Kache build cache daemon";
          wantedBy = [ "default.target" ];
          serviceConfig = {
            ExecStart = "%h/.cargo/bin/kache daemon run";
            Environment = "KACHE_LOG=kache=info";
            Restart = "on-failure";
            RestartSec = 5;
          };
        };
        hyprvoice = {
          description = "Hyprvoice service";
          wantedBy = [ "graphical-session.target" ];
          after = [ "graphical-session.target" ];
          partOf = [ "graphical-session.target" ];
          path = [
            "/etc/profiles/per-user/skyeav"
            "/run/current-system/sw"
          ];
          serviceConfig = {
            ExecStart = "%h/go/bin/hyprvoice serve";
            Environment = "YDOTOOL_SOCKET=/run/ydotoold/socket";
            Restart = "on-failure";
            RestartSec = 5;
          };
        };
      };
    };
  };
  # Security configuration
  security = {
    # Rtkit for audio
    rtkit.enable = true;
    # Polkit for VMs
    polkit.enable = true;
  };
}
