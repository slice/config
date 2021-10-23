{ config, pkgs, ... }:

{
  imports = [ ./fixup_fish_paths.nix ];

  # The actual user account isn't managed by nix-darwin (accordingly, it's not
  # in users.knownUsers either), but I need to tell it that I exist.
  users.users.slice = {
    name = "slice";
    description = "Skip Rousseau";
    home = "/Users/slice";
  };

  # Packages installed within system profile:
  environment.systemPackages = with pkgs; [
    # blissful text editing
    neovim
    neovim-remote

    # multimedia
    ffmpeg
    sox
    imagemagick
    yt-dlp

    # utilities
    croc
    graphviz
    jq
    ripgrep
    rlwrap
    curl
    tree
    aria
  ];

  # Use a custom configuration.nix location:
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/.config/nixpkgs/darwin.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Generate system rcs for shells that setup the nix environment.
  # Generally, the configurations generated by home-manager will be used
  # instead, but this can't hurt!
  programs.zsh.enable = true;
  programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
