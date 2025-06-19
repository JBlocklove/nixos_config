{ config, pkgs, lib, ... }:

let
# adjust this relative path if you move the module
prodConfigs = ./configs/productivity;

in
{

#####################
# install packages  #
#####################
	home.packages = with pkgs; [
		jupyter
	];

}


