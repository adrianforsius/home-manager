{lib, ...}: {
  enable = true;
  enableZshIntegration = true;
  settings = {
    add_newline = true;
    format = lib.concatStrings [
      "$username"
      "$hostname"
      "$localip"
      "$shlvl"
      "$singularity"
      "$kubernetes"
      "$directory"
      "$vcsh"
      "$fossil_branch"
      "$fossil_metrics"
      "$git_branch"
      "$git_commit"
      "$git_state"
      "$git_metrics"
      "$git_status"
      "$hg_branch"
      "$pijul_channel"
      "$docker_context"
      "$package"
      "$c"
      "$cmake"
      "$cobol"
      "$daml"
      "$dart"
      "$deno"
      "$dotnet"
      "$elixir"
      "$elm"
      "$erlang"
      "$fennel"
      "$golang"
      "$guix_shell"
      "$haskell"
      "$haxe"
      "$helm"
      "$java"
      "$julia"
      "$kotlin"
      "$gradle"
      "$lua"
      "$nim"
      "$nodejs"
      "$ocaml"
      "$opa"
      "$perl"
      "$php"
      "$pulumi"
      "$purescript"
      "$python"
      "$raku"
      "$rlang"
      "$red"
      "$ruby"
      "$rust"
      "$scala"
      "$solidity"
      "$swift"
      "$terraform"
      "$typst"
      "$vlang"
      "$vagrant"
      "$zig"
      "$buf"
      "$nix_shell"
      "$conda"
      "$meson"
      "$spack"
      "$memory_usage"
      # "$aws"
      "$gcloud"
      "$openstack"
      "$azure"
      "$direnv"
      "$env_var"
      "$crystal"
      "$custom"
      "$sudo"
      "$cmd_duration"

      # temp indicators
      "$line_break"
      "$jobs"
      "$battery"
      "$time"
      "$status"
      "$os"
      "$container"
      "$shell"

      # end of prompt
      "$character"
    ];
    directory = {
      truncate_to_repo = false;
      truncation_length = 0;
    };
    scan_timeout = 10;
    character = {
      success_symbol = "[\\$](bold green)";
      error_symbol = "[\\$](bold red)";
    };
  };
}
