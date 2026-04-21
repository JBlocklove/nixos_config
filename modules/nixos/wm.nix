{ inputs, config, pkgs, lib, ... }: {

	options = {
		hypr.enable = lib.mkEnableOption "Enable Hyprland WM";
		river.enable = lib.mkEnableOption "Enable River WM";
	};


	config = lib.mkMerge [
		# Assert that only one WM is enabled
		{assertions = [{
			assertion = !(config.hypr.enable && config.river.enable);
			message   = "You cannot enable both Hyprland and River at the same time.";
		}];}

		(lib.mkIf (config.hypr.enable || config.river.enable) {
			environment.systemPackages = with pkgs; [
				hyprlock
				hypridle
				waybar
				# dunst
				libnotify
				grim
				slurp
				swappy
				eww
				wl-clipboard
				adwaita-icon-theme
				gpu-screen-recorder
				inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
			];
			# gtk = {
			# 	enable = true;
			# 	iconTheme = {
			# 		name = "Adwaita";
			# 		package = pkgs.adwaita-icon-theme;
			# 	};
			# };
			environment.variables = {
				QT_QPA_PLATFORMTHEME = "gtk3";
			};
		})
		(lib.mkIf config.hypr.enable {
			environment.systemPackages = with pkgs; [
				hyprland
				hyprcursor
				hyprpaper
				nwg-look
				catppuccin-cursors.mochaDark
				lxappearance
				inputs.hyprdynamicmonitors.packages.${pkgs.stdenv.hostPlatform.system}.default
				xdg-desktop-portal-hyprland
			];
			programs.hyprland.enable = true;
			programs.hyprland.withUWSM = true;
			programs.hyprland.xwayland.enable = true;
			xdg.portal = {
				extraPortals = [
					pkgs.xdg-desktop-portal-hyprland
				];
			};
			services.upower = {
				enable = true;
			};
		})
		(lib.mkIf config.river.enable {
			environment.systemPackages = [
				pkgs.river
			];
		})

	];
}
