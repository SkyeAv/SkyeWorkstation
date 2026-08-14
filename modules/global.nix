{
  pkgs,
  config,
  ...
}:
{
  # Cross user configuration and programs
  fonts.packages = with pkgs; [
    vista-fonts
    corefonts
  ];
  # Global environment
  environment = {
    systemPackages = with pkgs; [
      wireguard-tools
      supergfxctl
      openconnect
      xmlstarlet
      coreutils
      minikube
      nssTools
      kubectl
      asusctl
      cacert
    ];
    variables = {
      EXTRA_LDFLAGS = "-L/lib -L${config.boot.kernelPackages.nvidiaPackages.beta}/lib";
      PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright-driver.browsers}";
      PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = "true";
      PLAYWRIGHT_HOST_PLATFORM_OVERRIDE = "ubuntu-24.04";
      CUDA_PATH = "${pkgs.cudatoolkit}";
      EXTRA_CCFLAGS = "-I/usr/include";
    };
    sessionVariables = {
      SSL_CERT_FILE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
      NIXOS_OZONE_WL = "1";
      LD_LIBRARY_PATH = [
        "${config.boot.kernelPackages.nvidiaPackages.beta}/lib"
        "/run/current-system/sw/share/nix-ld/lib"
        "${pkgs.ncurses}/lib"
      ];
    };
  };
  programs = {
    bash.enable = true;
    zsh.enable = true;
    # Firefox
    firefox.enable = true;
    # Links compilers to fhs locations
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        config.boot.kernelPackages.nvidiaPackages.beta
        stdenv.cc.cc.lib
        openssl.dev
        portaudio
      ];
    };
    # Subuid support
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    # Steam configuration
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
    # Ydotool
    ydotool.enable = true;
    # Comma
    nix-index-database.comma.enable = true;
    # AppImage
    appimage = {
      enable = true;
      binfmt = true;
      package = pkgs.appimage-run;
    };
  };
  # Do not modify this
  system.stateVersion = "25.11";
}
