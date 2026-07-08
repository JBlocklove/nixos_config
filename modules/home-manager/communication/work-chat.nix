{ config, pkgs, ... }:

let
	communicationConfigs = ../configs/communication;
in {


    #####################
    # install packages  #
    #####################
	home.packages = with pkgs; [
		webcord # only need until vesktop fixes multiple user issue
        slack
        zoom-us
	];
}

