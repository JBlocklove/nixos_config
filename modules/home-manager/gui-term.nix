{ pkgs, ... }:

let
	termConfigs = ./configs/term;
in
{
    imports = [
        ./shell.nix
    ];

    #####################
    # install packages  #
    #####################
	home.packages = with pkgs; [
		chafa
		poppler-utils
		foot
	];

    #######################################
    # symlink config files into ~/.config #
    #######################################
	home.file = {
		".config/foot/" = {
			source = "${termConfigs}/foot/";
			recursive = true;
		};
	};
}

