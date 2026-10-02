# ./overlays/freecad-pinned.nix
inputs: final: prev:
let
    stablePkgs = import inputs.nixpkgs-stable {
        system = prev.stdenv.hostPlatform.system;
        # Explicitly pass simple config options instead of 'prev.config'
        config = {
            allowUnfree = true;
        };
    };
in
{
    freecad = stablePkgs.freecad;
    freecad-wayland = stablePkgs.freecad-wayland;
}
