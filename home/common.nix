{ config, pkgs, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  home.packages = with pkgs; [
    # config shell
    oh-my-zsh
    tmux
    zplug
    fzf
    direnv

    # development
    gh
    git
    nodejs_22
    azure-cli
    go
    uv
    lazygit
    curl
    kubectl
    kubernetes-helm
    k9s
    imagemagick
    mermaid-cli
    d2
    gnuplot

    # cloud
    awscli2

    # editor
    neovim
    ripgrep
    lynx
    luarocks
    fd
    isort
    prettierd
    stylua

    # lsp
    lua-language-server
    typescript-language-server
    yaml-language-server
    pyright
    nil
    gopls
    lua5_1

    # puml
    plantuml
    graphviz

    # llms
    opencode

  ];

  home.file.".tmux.conf".source = ../tmux.conf;

  programs.zsh = {
    enable = true;
    initContent = builtins.readFile ../zshrc;
    envExtra = builtins.readFile ~/.zshenv.append;
  };

  home.stateVersion = "25.05";
  home.username = "jakub";
}
