{ config, pkgs, ... }: {
    #####################
    # install packages  #
    #####################
	home.packages = with pkgs; [
        gimp
        pinta
	];
}

