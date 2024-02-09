{
  user,
  modules,
}: {
  useGlobalPkgs = true;
  useUserPackages = true;
  backupFileExtension = "bak";
  extraSpecialArgs = {inherit inputs username;};
  users."${user.name}".imports = modules;
}
