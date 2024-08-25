{
  description = "A flake to install Neovim and set up its configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";  # You can pin to a specific version if you want
  };

  outputs = { self, nixpkgs }: {
    devShell = nixpkgs.lib.mkShell {
      buildInputs = [
        nixpkgs.neovim
        nixpkgs.git
      ];

      shellHook = ''
        CONFIG_DIR=$HOME/.config/nvim
        REPO_URL="https://github.com/mescam/nvim.git"

        # Clone or pull the latest Neovim config
        if [ -d "$CONFIG_DIR" ]; then
          echo "Updating existing Neovim configuration..."
          git -C "$CONFIG_DIR" pull
        else
          echo "Cloning Neovim configuration..."
          git clone "$REPO_URL" "$CONFIG_DIR"
        fi

        echo "Neovim setup complete!"
      '';
    };
  };
}

