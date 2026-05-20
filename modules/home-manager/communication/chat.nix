{ config, pkgs, ... }:

let
	communicationConfigs = ../configs/communication;
in {


    #####################
    # install packages  #
    #####################
	home.packages = with pkgs; [
        signal-desktop
        vesktop
        slack
        zoom-us
        element-desktop
	];
}

