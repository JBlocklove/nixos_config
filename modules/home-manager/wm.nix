{ pkgs, inputs, ... }:

let
	wmConfigs = ./configs/wm;

	rofiScripts = pkgs.runCommand "rofi-scripts" {} ''
		mkdir -p $out/bin
		cp -r ${wmConfigs}/rofi/local/* $out/bin/
		chmod +x $out/bin/*
	'';

in {

	home.packages = with pkgs; [
        # Hypr
		hyprland
        hypridle
        hyprcursor

        # Theming
        nwg-look
        adwaita-icon-theme
        catppuccin-cursors.mochaDark

        # Bar and a bunch of other stuff
        noctalia-shell

        # Util
        wl-clipboard
        libnotify

        # Launcher
		rofi
		rofiScripts

        # Monitor switching
		inputs.hyprdynamicmonitors.packages.${pkgs.stdenv.hostPlatform.system}.default
        wdisplays
		
	];

	home.file = {
		".config/hypr/" = {
			source = "${wmConfigs}/hypr";
			recursive = true;
		};

		".config/hyprdynamicmonitors/" = {
			source = "${wmConfigs}/hyprdynamicmonitors";
			recursive = true;
		};

		".config/rofi/" = {
			source = "${wmConfigs}/rofi/config";
			recursive = true;
		};

		".config/noctalia/" = {
			source = "${wmConfigs}/noctalia";
			recursive = true;
		};

        "pictures/wallpapers/" = {
            source = "${wmConfigs}/wallpapers";
            recursive = true;
        };
	};
}

