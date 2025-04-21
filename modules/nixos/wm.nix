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
			environment.systemPackages = [
				pkgs.hyprlock
				pkgs.hypridle
				pkgs.waybar
				pkgs.dunst
				(pkgs.flameshot.override { enableWlrSupport = true; })
				pkgs.grim
			];
		})
		(lib.mkIf config.hypr.enable {
			environment.systemPackages = [
				pkgs.hyprland
				pkgs.hyprcursor
				pkgs.nwg-look
				pkgs.catppuccin-cursors.mochaDark
				pkgs.lxappearance
			];
			programs.hyprland.enable = true;
			programs.hyprland.withUWSM = true;
			programs.hyprland.xwayland.enable = true;
		})
		(lib.mkIf config.river.enable {
			environment.systemPackages = [
				pkgs.river
			];
		})

	];
}
