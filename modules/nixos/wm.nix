{ config, pkgs, lib, ... }: {

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
				dunst
				grim
				slurp
				swappy
				eww
			];
		})
		(lib.mkIf config.hypr.enable {
			environment.systemPackages = with pkgs; [
				hyprland
				hyprcursor
				hyprpaper
				nwg-look
				catppuccin-cursors.mochaDark
				lxappearance
			];
			programs.hyprland.enable = true;
			programs.hyprland.withUWSM = true;
			programs.hyprland.xwayland.enable = true;
			xdg.portal = {
				extraPortals = [
					pkgs.xdg-desktop-portal-hyprland
				];
			};
		})
		(lib.mkIf config.river.enable {
			environment.systemPackages = [
				pkgs.river
			];
		})

	];
}
