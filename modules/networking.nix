{
  pkgs,
  ...
}:
{
  # Networking configuration
  networking = {
    hostName = "skyetop";
    networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-openconnect
      ];
    };
    firewall = {
      enable = true;
      allowedTCPPorts = [
        7070
        4447
        4444
      ];
    };
  };
}
