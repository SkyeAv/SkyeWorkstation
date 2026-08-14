{
  pkgs,
  ...
}:
{
  # Home manager configuration
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.skyeav = {
      home = {
        # Do not modify this
        stateVersion = "25.11";
        # Append vars to path
        sessionPath = [
          "$HOME/.kimi-code/bin"
          "$HOME/.local/bin"
          "$HOME/go/bin"
          "$HOME/.cargo/bin"
        ];
        # Route all cargo builds through kache. Absolute path => works in ANY shell
        # (pi agents / non-login bash have no ~/.cargo/bin on PATH).
        file.".cargo/config.toml".text = ''
          [build]
          rustc-wrapper = "/home/skyeav/.cargo/bin/kache"
        '';
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
            gateway = "ssh -J sgoetz@gateway.systemsbiology.net sgoetz@wenceslaus";
            rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#skyeav";
            wenceslaus = "ssh sgoetz@wenceslaus";
            ht1 = "ssh goetzs@ht1.renci.org";
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
        # Zed configuration
        zed-editor = {
          enable = true;
          extensions = [
            "material-icon-theme"
            "docker-compose"
            "github-actions"
            "git-firefly"
            "ayu-darker"
            "dockerfile"
            "elixir"
            "julia"
            "latex"
            "perl"
            "make"
            "toml"
            "ruff"
            "log"
            "nim"
            "nix"
          ];
          installRemoteServer = true;
          userSettings = {
            theme = {
              mode = "dark";
              dark = "Ayu Darker";
              light = "Ayu Darker";
            };
            terminal = {
              shell = "system";
            };
            base_keymap = "VSCode";
          };
        };
        # Neovim configuration
        neovim = {
          enable = true;
          viAlias = true;
          vimAlias = true;
          withRuby = false;
          withPython3 = false;
        };
        # Kitty configuration
        kitty = {
          enable = true;
          shellIntegration.enableZshIntegration = true;
        };
        # Chromium
        chromium.enable = true;
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
            yank
          ];
          extraConfig = ''
            set -g mode-keys vi
            set -g extended-keys on
            set -g extended-keys-format csi-u

            bind-key -T copy-mode-vi v send-keys -X begin-selection
            bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy"
            bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "wl-copy"
          '';
        };
      };
    };
  };
}
