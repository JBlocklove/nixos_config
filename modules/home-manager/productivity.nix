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
		# super-productivity
		vdirsyncer
		khal
		khard
		libreoffice
		tomat
		uair
	];
#######################################
# handle secrets in configs with sops #
#######################################
	sops.secrets = {
		vdirsyncer-config = {
			sopsFile = "${prodConfigs}/vdirsyncer/config";
			format = "binary";
			path = "${config.home.homeDirectory}/.config/vdirsyncer/config";
			mode = "0400";
		};

		khal-config = {
			sopsFile = "${prodConfigs}/khal/config";
			format = "binary";
			path = "${config.home.homeDirectory}/.config/khal/config";
			mode = "0400";
		};
	};


#######################################
# symlink config files into ~/.config #
#######################################
	home.file = {
		# ".config/vdirsyncer/" = {
		# 	source = "${prodConfigs}/vdirsyncer/";
		# 	recursive = true;
		# };

		# ".config/khal/" = {
		# 	source = "${prodConfigs}/khal/";
		# 	recursive = true;
		# };

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

