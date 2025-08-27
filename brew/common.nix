{
  config,
  pkgs,
  lib,
  ...
}:

let
  taps = [ "homebrew/bundle" ];

  brews = [ ];

  casks = [
    "1password"
    "balenaetcher"
    "ghostty"
    "orcaslicer"
    "raycast"
    "brave-browser"
    "karabiner-elements"
    "claude-code"
    "slack"
    "microsoft-teams"

    "localsend"
    "winbox"

  ];
in
with lib;
{
  home.sessionPath = [ "/opt/homebrew/bin" ];

  home.file.".Brewfile" = {
    text =
      (concatMapStrings (
        tap:
        ''tap "''
        + tap
        + ''
          "
        ''

      ) taps)
      + (concatMapStrings (
        brew:
        ''brew "''
        + brew
        + ''
          "
        ''

      ) brews)
      + (concatMapStrings (
        cask:
        ''cask "''
        + cask
        + ''
          "
        ''

      ) casks);
    onChange = ''
      /opt/homebrew/bin/brew bundle install --cleanup --no-upgrade --force --no-lock --global""
    '';
  };
}
