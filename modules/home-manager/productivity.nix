{ config, pkgs, lib, ... }:

let
# adjust this relative path if you move the module
prodConfigs = ./configs/productivity;

in
{

#####################
# install packages  #
#####################
	home.packages = with pkgs; [
		super-productivity
		vdirsyncer
		khal
		khard
		libreoffice
	];

#######################################
# symlink config files into ~/.config #
#######################################
	home.file = {
		#".config/superProductivity/" = {
		#	source = "${prodConfigs}/superProductivity/";
		#	recursive = true;
		#};

		".config/vdirsyncer/" = {
			source = "${prodConfigs}/vdirsyncer/";
			recursive = true;
		};

		".config/khal/" = {
			source = "${prodConfigs}/khal/";
			recursive = true;
		};

		".config/khard/" = {
			source = "${prodConfigs}/khard/";
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
				ExecStart = "/home/jason/.nix-profile/bin/vdirsyncer sync";
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

