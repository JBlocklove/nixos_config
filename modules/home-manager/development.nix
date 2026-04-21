{ config, pkgs, lib, ... }:

let
# adjust this relative path if you move the module
devConfigs = ./configs/dev;

in
{

#####################
# install packages  #
#####################
	home.packages = with pkgs; [
		jupyter
	];

}


