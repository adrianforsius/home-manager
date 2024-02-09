{
  nixpkgs,
  overlays,
  inputs,
}: machine: {
  config,
  home-manager,
}: let
  # The config files for this system.
  machineConfig = ../machine/${machine}.nix;
  userOSConfig = ../user/${config.user.name}/${config.name}.nix;
  userHMConfig = ../user/${config.user.name}/home.nix;
in
  config.func rec {
    system = config.name;

    modules = [
      # Apply our overlays. Overlays are keyed by system type so we have
      # to go through and apply our system type. We do this first so
      # the overlays are available globally.
      {nixpkgs.overlays = overlays;}

      machineConfig
      userOSConfig
      home-manager.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {inherit (config) user;};
        home-manager.users.${config.user.name}.imports = [userHMConfig];
      }

      # We expose some extra arguments so that our modules can parameterize
      # better based on these values.
      {
        config._module.args = {inherit config inputs;};
      }
    ];
  }
