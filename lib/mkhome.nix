{
  user,
  modules,
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit user;};
    users."${user.name}".imports = modules;
  };
}
