{ pkgs, ... }: {

#####################
# install packages  #
#####################
	home.packages = with pkgs; [
        # Just working with languages
        gcc
        python3
		# jupyter
	];

}


