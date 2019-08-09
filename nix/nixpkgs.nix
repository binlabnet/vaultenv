let
  nixpkgsRev = "a2d7e9b875e8ba7fd15b989cf2d80be4e183dc72";
  nixpkgsTar = fetchTarball {
      url = "https://github.com/nh2/nixpkgs/archive/${nixpkgsRev}.tar.gz";
      sha256 = "sha256:1hnmp637r99qd6g0sbx4w3za564gbzwl5c4z0x7fvn7kfi2jp1hx";
    };
  nixpkgsConfig = {
    packageOverrides = pkgsOld: {
      haskellPackages = pkgsOld.haskellPackages.override {
        overrides = haskellNew: haskellOld: {
          dotenv = haskellOld.callPackage ./dotenv.nix {};
        };
      };
    };
  };
in
  # Lambda so we can pass in custom configuration/options to this file later.
  # This seems to be a standard Nix pattern. Currently, we don't take any
  # arguments.
  {}: import "${nixpkgsTar}/default.nix" { config = nixpkgsConfig; }