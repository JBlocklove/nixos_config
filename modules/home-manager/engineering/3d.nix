{ pkgs, ... }: {

	#####################
	# install packages  #
	#####################
	home.packages = with pkgs; [
	    freecad-wayland
		openscad
	    prusa-slicer
	];

}



