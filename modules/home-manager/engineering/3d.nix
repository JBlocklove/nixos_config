{ pkgs, ... }: {

	#####################
	# install packages  #
	#####################
	home.packages = with pkgs; [
	    freecad-wayland
	    prusa-slicer
	];

}



