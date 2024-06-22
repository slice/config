{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Skip R";
    userEmail = "tinyslices@gmail.com";

    delta = {
      enable = false;
      options = {
        line-numbers = true;
        features = "decorations";
        syntax-theme = "ansi";
      };
    };

    extraConfig =
      let
        ghHelper = {
          helper = "!/Users/slice/.nix-profile/bin/gh auth git-credential";
        };
      in
      {
        url."ssh://git@github.com/".insteadOf = "https://github.com/";
        commit.verbose = true;
        format.pretty = "tformat:%C(bold yellow)%h%Creset %<|(82,trunc)%s %Creset%C(bold white)%cr%C(nobold)/%ch%Creset %C(bold)(%an)%C(auto)%d";
        push.default = "current";
        core.ignorecase = false;
        color.ui = true;
        color.diff.meta = "reverse";
        pull.ff = "only";
        init.defaultBranch = "main";
        branch.sort = "-committerdate";
        # diff.colorMoved = "default";
        "credential \"https://github.com\"" = ghHelper;
        "credential \"https://gist.github.com\"" = ghHelper;
      };

    ignores = [
      "*~"
      "*.swp"
      ".DS_Store"
      "__MACOSX"
    ];
  };
}
