{ config, pkgs, inputs, ... }:

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
		# hyprland
        hypridle
        hyprcursor

        # Theming
        nwg-look
        adwaita-icon-theme
        catppuccin-cursors.mochaDark

        # Bar and a bunch of other stuff
        noctalia-shell
		inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

        # Util
        wl-clipboard
        libnotify

        # Launcher
		rofi
		rofiScripts

        # Monitor switching
		# inputs.hyprdynamicmonitors.packages.${pkgs.stdenv.hostPlatform.system}.default
		hyprmoncfg
        wdisplays

		# Screen sharing
		# xwaylandvideobridge
		
	];

	home.file = {
		".config/hypr/" = {
			# source = config.lib.file.mkOutOfStoreSymlink "${wmConfigs}/hypr";
			source = config.lib.file.mkOutOfStoreSymlink "/home/jason/nixos/modules/home-manager/configs/wm/hypr/";
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

		# manage noctalia out of nix store so the UI can write settings changes
		".config/noctalia/" = {
			source = config.lib.file.mkOutOfStoreSymlink "/home/jason/nixos/modules/home-manager/configs/wm/noctalia/";
			recursive = true;
		};

        "pictures/wallpapers/" = {
            source = "${wmConfigs}/wallpapers";
            recursive = true;
        };
	};
}

