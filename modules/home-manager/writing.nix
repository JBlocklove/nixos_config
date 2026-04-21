{ config, pkgs, lib, ... }:

let
	writingConfigs = ./configs/writing;

in{
	#####################
	# install packages  #
	#####################
	home.packages = with pkgs; [
		texliveFull
		zathura
		zotero
	];
	
	# ## Zotero works headlessly but then I can't open the UI when I have to
	# systemd.user = {
	# 	services.zotero-headless = {
	# 		Unit = {
	# 			Description = "Start Zotero in headless mode";
	# 		};
	# 		Service = {
	# 			Type = "oneshot";
	# 			ExecStart = "${config.home.profileDirectory}/bin/zotero --headless";
	# 		};
	# 		Install = {
	# 			WantedBy = [ "default.target" ];
	# 		};
	# 	};
	# };
}
