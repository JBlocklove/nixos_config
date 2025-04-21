{ config, pkgs, lib, ... }: {

  options = {
    gaming.enable = lib.mkEnableOption "enables gaming programs and setup";
  };

  config = lib.mkIf config.gaming.enable {
    environment.systemPackages = with pkgs; [
		steam
		lutris
		heroic
    ];
  };
}

