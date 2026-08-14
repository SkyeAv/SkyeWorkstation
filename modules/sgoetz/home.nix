{
  pkgs,
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
        rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#skyeav";
        zed = "zeditor";
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
