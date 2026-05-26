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
		webcord # only need until vesktop fixes multiple user issue
        slack
        zoom-us
        element-desktop
	];
}

