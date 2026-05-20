{ config, pkgs, lib, ... }:

let
	pimConfigs = ./configs/pim;

in
{

#####################
# install packages  #
#####################
	home.packages = with pkgs; [
		vdirsyncer
		khal
		khard
	];
#######################################
# handle secrets in configs with sops #
#######################################
	sops.secrets = {
		vdirsyncer-config = {
			sopsFile = "${pimConfigs}/vdirsyncer/config";
			format = "binary";
			path = "${config.home.homeDirectory}/.config/vdirsyncer/config";
			mode = "0400";
		};

		khal-config = {
			sopsFile = "${pimConfigs}/khal/config";
			format = "binary";
			path = "${config.home.homeDirectory}/.config/khal/config";
			mode = "0400";
		};
	};


#######################################
# symlink config files into ~/.config #
#######################################
	home.file = {

		".config/khard/" = {
			source = "${pimConfigs}/khard/";
			recursive = true;
		};

	};

	systemd.user = {
		services.vdirsync = {
			Unit = {
				Description = "Vdirsyncer synchronization script";
			};
			Service = {
				Type = "oneshot";
				ExecStart = "${config.home.profileDirectory}/bin/vdirsyncer sync";
			};
			Install = {
				WantedBy = [ "default.target" ];
			};
		};

		timers.vdirsync = {
			Unit = {
				Description = "Run vdirsyncer every 5 minutes";
			};
			Timer = {
				OnBootSec = "1min";
				OnUnitActiveSec = "5min";
				Persistent = true;
				Unit = "vdirsync.service";
			};
			Install = {
				WantedBy = [ "timers.target" ];
			};
		};
	};
}

