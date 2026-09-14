inputs: final: prev:
let
  stablePkgs = import inputs.nixpkgs-stable {
    system = prev.system;
    config = {
    };
  };
in
{
  zotero = stablePkgs.zotero;
}
