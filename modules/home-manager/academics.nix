{ config, pkgs, lib, ... }:

let
# adjust this relative path if you move the module
academicConfigs = ./configs/academics;

in
{

#####################
# install packages  #
#####################
	home.packages = with pkgs; [
		zotero
	];


	## Fuck zotero and it's fake headlessness
	#systemd.user = {
	#	services.zotero-headless = {
	#		Unit = {
	#			Description = "Start Zotero in headless mode";
	#		};
	#		Service = {
	#			Type = "oneshot";
	#			ExecStart = "${config.home.profileDirectory}/bin/zotero --headless";
	#		};
	#		Install = {
	#			WantedBy = [ "default.target" ];
	#		};
	#	};
	#};
}



