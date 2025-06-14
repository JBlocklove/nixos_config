{ config, pkgs, lib, ... }:

let
# adjust this relative path if you move the module
managementConfigs = ./configs/management;

in
{

#####################
# install packages  #
#####################
	home.packages = with pkgs; [
		calibre
	];

}



