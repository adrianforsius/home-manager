{
  user,
  modules,
}:
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    # move pre-existing files that home-manager now manages aside instead of failing activation
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit user; };
    users."${user.name}".imports = modules;
  };
}
