{ config, pkgs, lib, ... }: {

	options = {
	};

	config = {
		fonts = {
			enableDefaultPackages = true;
			packages = with pkgs; [
				nerd-fonts.jetbrains-mono
			];

			fontconfig = {
				defaultFonts = {
					serif = [ "Liberation Serif" ];
					sansSerif = [ "Liberation Sans" ];
					monospace = [ "JerBrainsMonoNL NF" ];
				};
			};
		};
	};
}

