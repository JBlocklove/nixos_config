{ config, pkgs, lib, ... }: {

  options = {
    engineering.enable = lib.mkEnableOption "enables engineering programs";
  };

  config = lib.mkIf config.engineering.enable {
    environment.systemPackages = with pkgs; [
		freecad-wayland
		kicad
		#kicadAddons
		prusa-slicer
    ];
  };
}


