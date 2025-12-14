{ config, pkgs, lib, ... }: {

	options = {
		video.enable = lib.mkEnableOption "enables video stuff programs";
	};

	config = lib.mkIf config.video.enable {

		environment.systemPackages = with pkgs; [
			(wrapOBS {
				plugins = with obs-studio-plugins; [
					wlrobs
					obs-backgroundremoval
					obs-pipewire-audio-capture
				];
			})
		];

	};
}

