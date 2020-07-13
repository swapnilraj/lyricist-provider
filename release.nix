let
  pkgs = import <nixpkgs> { };
in
  { lyricist_provider = pkgs.haskellPackages.callPackage ./default.nix { };
  }
