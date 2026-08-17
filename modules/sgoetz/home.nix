{
  pkgs,
  inputs,
  ...
}:
{
  home = {
    username = "sgoetz";
    homeDirectory = "/home/sgoetz";
    # Do not modify this
    stateVersion = "25.11";
    # Append dirs to path
    sessionPath = [
      "$HOME/.kimi-code/bin"
      "$HOME/.local/bin"
      "$HOME/go/bin"
      "$HOME/.cargo/bin"
    ];
    # Environment variables
    sessionVariables = {
      SSL_CERT_FILE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
      CUDA_PATH = "${pkgs.cudaPackages.cudatoolkit}";
      PYTHONIOENCODING = "utf-8";
    };
    # User package configuration
    packages = with pkgs; [
      inputs.agent-of-empires.packages.${pkgs.system}.aoe-with-web
      beamMinimal28Packages.elixir_1_19
      # beamMinimal28Packages.elixir-ls
      # conflicts with cudatoolkit liscence path
      typescript-language-server
      cudaPackages.cudatoolkit
      yaml-language-server
      # rust-analyzer
      # removed due to conflicting subpaths
      cloudflared
      nixfmt-tree
      claude-code
      python314
      fastfetch
      nodejs_24
      nix-diff
      ast-grep
      usbutils
      pciutils
      awscli2
      pyright
      gnumake
      ripgrep
      psmisc
      libzip
      libgcc
      rustup
      pandoc
      duckdb
      gopls
      cmake
      ninja
      procs
      rsync
      aria2
      pdftk
      unzip
      curl
      wget
      tree
      file
      htop
      btop
      dust
      lshw
      acpi
      gawk
      perl
      nixd
      ruff
      zlib
      ghc
      lua
      nil
      gcc
      bun
      eza
      bat
      fzf
      zip
      fd
      jq
      yq
      go
      gh
      uv
    ];
  };
  programs = {
    # Zsh configuration
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      # Zsh aliases
      shellAliases = {
        amphetamine = ''systemd-inhibit --what=idle:sleep --why="Presentation" sleep infinity'';
        rebuild = "home-manager switch --flake /local_raid1/sgoetz/home-manager#sgoetz";
        pi = "npx pi";
        ps = "procs";
        top = "htop";
        du = "dust";
        ls = "eza";
        df = "duf";
        cd = "z";
      };
      # Oh my zsh configuration
      oh-my-zsh = {
        enable = true;
        plugins = [
          "extract"
          "git"
        ];
        theme = "eastwood";
      };
      history.size = 100;
    };
    # Nix package lookup
    nix-index = {
      enable = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };
    # Zoxide integration
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    # Direnv integration
    direnv = {
      enable = true;
      enableZshIntegration = true;
    };
    # Carapace integration
    carapace = {
      enable = true;
      enableZshIntegration = true;
    };
    # Nushell
    nushell = {
      enable = true;
    };
    # Neovim configuration
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      withRuby = false;
      withPython3 = false;
    };
    # Tmux configuration
    tmux = {
      enable = true;
      baseIndex = 1;
      historyLimit = 10000;
      mouse = true;
      keyMode = "vi";
      plugins = with pkgs.tmuxPlugins; [
        catppuccin
        sensible
      ];
      extraConfig = ''
        set -g mode-keys vi
        set -g extended-keys on
        set -g extended-keys-format csi-u

        bind-key -T copy-mode-vi v send-keys -X begin-selection
      '';
    };
  };
}
