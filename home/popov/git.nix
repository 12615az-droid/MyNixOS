{ ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "popov";
        email = "12615az@gmail.com";
      };

      init.defaultBranch = "main";

      core = {
        editor = "micro";
        autocrlf = "input";
      };

      pull.rebase = false;
    };
  };
}
