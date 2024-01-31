{...}: {
  enable = true;
  settings = {
    "*" = {
      charset = "utf-8";

      end_of_line = "LF";
      insert_final_newline = true;
      trim_trailing_whitespace = true;

      indent_style = "space";
      indent_size = 4;
    };

    "Makefile" = {
      indent_style = "tab";
    };

    "*.go" = {
      indent_style = "tab";
      indent_size = 8;
    };

    ".vimrc" = {
      indent_style = "tab";
      indent_size = 2;
    };

    ".*" = {
      indent_style = "space";
      indent_size = 2;
    };

    "*.sh" = {
      indent_style = "space";
      indent_size = 2;
    };

    "*.nix" = {
      indent_style = "space";
      indent_size = 2;
    };

    "[{*.json,*.js,*.ts}]" = {
      indent_style = "space";
      indent_size = 2;
    };

    "[{*.yaml,*.yml}]" = {
      indent_style = "space";
      indent_size = 2;
    };
  };
}
