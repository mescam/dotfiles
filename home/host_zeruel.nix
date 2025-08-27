{ config, pkgs, ... }:

{
  imports = [ ../brew/common.nix ];
  home.packages = with pkgs; [
    podman
    terraform
    jira-cli-go
  ];
}

