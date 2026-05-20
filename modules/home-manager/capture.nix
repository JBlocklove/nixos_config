{ config, pkgs, ... }: {

#####################
# install packages  #
#####################
	home.packages = with pkgs; [
        (wrapOBS {
		    plugins = with obs-studio-plugins; [
			    wlrobs
			    obs-backgroundremoval
				obs-pipewire-audio-capture
			];
		})
        gpu-screen-recorder
        grim
        slurp
        swappy
	];
}


