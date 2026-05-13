{ pkgs, username, ... }:
{

  environment.sessionVariables = {
    KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";
  };

  environment.systemPackages = with pkgs; [
    kubectl
    kubernetes-helm
    k9s               
    fluxcd            
    podman-tui        
    podman-compose
  ];

  users.users.${username}.extraGroups = [ "docker" "k3s" "podman" ];

  # Docker rootless
  virtualisation.docker.rootless.enable = true;
  virtualisation.docker.rootless.setSocketVariable = true;
  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings = {
    dns = [ "1.1.1.1" "8.8.8.8" ];
  };

  virtualisation.podman.enable = true;
  virtualisation.podman.dockerCompat = false;               # Set to true for 'docker' command to run podman
  virtualisation.podman.defaultNetwork.settings.dns_enabled = true;

  # Open Firewall ports for K3s
  networking.firewall.allowedTCPPorts = [ 6443 ]; # API Server
  networking.firewall.allowedUDPPorts = [ 8472 ]; # Flannel VXLAN
  
  services.k3s.enable = true;
  services.k3s.role = "server";
  services.k3s.extraFlags = "--disable traefik --write-kubeconfig-mode 644";

}

