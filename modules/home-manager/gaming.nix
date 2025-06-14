{ config, pkgs, lib, ... }: {
#####################
# install packages  #
#####################
  options = {
    gaming.enable = lib.mkEnableOption "enables gaming programs and setup";
  };

  config = lib.mkIf config.gaming.enable {
	home.packages = with pkgs; [
		steam
		lutris
		heroic
	];
  };
}


