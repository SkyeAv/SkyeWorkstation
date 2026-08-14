{
  pkgs,
  inputs,
  ...
}:
{
  home.packages = with pkgs; [
    # --- Agent of Empires ---
    inputs.agent-of-empires.packages.${pkgs.system}.aoe-with-web

    # --- Language runtimes / compilers ---
    beamMinimal28Packages.elixir_1_19
    python314
    nodejs_24
    go
    rustup
    ghc
    lua
    perl

    # --- Language servers / linters ---
    beamMinimal28Packages.elixir-ls
    typescript-language-server
    yaml-language-server
    rust-analyzer
    pyright
    gopls
    nixd
    nil
    ruff

    # --- Build tools ---
    gcc
    cmake
    ninja
    gnumake
    gh
    uv
    bun
    zlib
    libzip
    libgcc

    # --- Dev / ops ---
    awscli2
    cloudflared
    docker-sbx
    podman-compose
    ast-grep
    graphviz
    qrencode
    nix-diff
    nixfmt-tree
    pandoc
    ffmpeg
    imagemagick
    ghostscript
    duckdb
    postgresql
    clickhouse
    texliveFull
    cudaPackages.cudatoolkit

    # --- Terminal utilities ---
    ripgrep
    eza
    bat
    fzf
    fd
    htop
    btop
    dust
    procs
    jq
    yq
    tree
    file
    unzip
    zip
    curl
    wget
    rsync
    aria2
    pdftk
    fastfetch
    lshw
    usbutils
    pciutils
    acpi
    psmisc
    gawk
  ];
}
