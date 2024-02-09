{
  user,
  modules,
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    extraSpecialArgs = {inherit inputs username;};
    users."${user.name}".imports = modules;
  };
}
