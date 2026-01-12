{ config, pkgs, lib, ... }:

let
# adjust this relative path if you move the module
emailConfigs = ./configs/email;
in
{
#####################
# install packages  #
#####################
	home.packages = with pkgs; [
		isync      # mbsync
		msmtp      # SMTP
		neomutt    # MUA
		notmuch    # search/index
		html2text
		glow
		lynx
		curl
		urlscan
		pandoc
	];

################################################
# symlink your real config files into ~/.config #
################################################
	home.file = {
# mbsync
		".config/isync/" = {
			source = "${emailConfigs}/isync/";
			recursive = true;
		};

# msmtp
		".config/msmtp/" = {
			source = "${emailConfigs}/msmtp/";
			recursive = true;
		};

# neomutt
		".config/neomutt/" = {
			source = "${emailConfigs}/neomutt/";
			recursive = true;
		};

# notmuch
		".config/notmuch/" = {
			source = "${emailConfigs}/notmuch/";
			recursive = true;
		};

# glow
		".config/glow/" = {
			source = "${emailConfigs}/glow/";
			recursive = true;
		};

# mailsync
		".local/bin/mailsync" = {
			source = "${emailConfigs}/mailsync";
		};

# standalone neomutt
		".local/bin/neomutt-solo" = {
			source = "${emailConfigs}/neomutt-solo";
		};

## # khard
## ".config/khard/khard.conf" = {
##   source = "${emailConfigs}/khard.conf";
## };
	};
################################
# Mail syncinc systemd service # 
################################

	systemd.user = {
		services.mailsync = {
			Unit = {
				Description = "Mail synchronization script";
			};
			Service = {
				Type = "oneshot";
				ExecStart = "${config.home.homeDirectory}/.local/bin/mailsync";
			};
			Install = {
				WantedBy = [ "default.target" ];
			};
		};

		timers.mailsync = {
			Unit = {
				Description = "Run mailsync service every 5 minutes";
			};
			Timer = {
				OnBootSec = "1min";
				OnUnitActiveSec = "5min";
				Persistent = true;
				Unit = "mailsync.service";
			};
			Install = {
				WantedBy = [ "timers.target" ];
			};
		};
	};
}
