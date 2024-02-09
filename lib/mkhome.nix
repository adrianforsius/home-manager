{
  user,
  modules,
  inputs,
  ...
}: {
  useGlobalPkgs = true;
  useUserPackages = true;
  backupFileExtension = "bak";
  extraSpecialArgs = {inherit user inputs;};
  users."${user.name}".imports = modules;
}
