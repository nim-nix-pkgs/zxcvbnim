{
  description = ''A zxcvbn clone for Nim. Written in Nim'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."zxcvbnim-main".dir   = "main";
  inputs."zxcvbnim-main".owner = "nim-nix-pkgs";
  inputs."zxcvbnim-main".ref   = "master";
  inputs."zxcvbnim-main".repo  = "zxcvbnim";
  inputs."zxcvbnim-main".type  = "github";
  inputs."zxcvbnim-main".inputs.nixpkgs.follows = "nixpkgs";
  inputs."zxcvbnim-main".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}