{ config, pkgs, lib, ... }: {

	options = {
		audio.enable = lib.mkEnableOption "enables audio stuff programs";
	};

	config = lib.mkIf config.engineering.enable {

		environment.systemPackages = with pkgs; [
			pavucontrol
			qpwgraph
			alsa-utils
			ncmpcpp
			mpc
		];

		security.rtkit.enable = true;
		services.pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
			jack.enable = true;
		};


#services.mopidy = {
#	enable = true;
#	extensionPackages = with pkgs; [
#	  mopidy-mpd
#	  mopidy-jellyfin
#	  mopidy-local
#	];
#};

	};
							}




