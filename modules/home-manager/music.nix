{ config, pkgs, ... }:

let
	musicConfigs = ./configs/music;
in {

	home.packages = with pkgs; [
		ncmpcpp
		mpc
		picard
		chromaprint
		sshfs
		yt-dlp
	];

	services.mopidy = {
		enable = true;
		extensionPackages = with pkgs; [
			mopidy-mpd
			mopidy-jellyfin
			mopidy-local
		];
	};

	systemd.user.services.fix-mopidy = {
		Unit = {
			Description = "Runs 1 second of silence in Mopidy to fix a glitch";
			Requires = [ "mopidy.service" ];
		};

		Install = {
			WantedBy = [ "multi-user.target" ];
		};

		Service = {
			Type = "oneshot";
			ExecStart = "/home/jason/.config/mopidy/fix_mopidy.sh";
			Restart = "on-failure";
		};
	};

	sops.secrets = {
		mopidy-config = {
			sopsFile = "${prodConfigs}/music/mopidy.conf";
			format = "binary";
			path = "${config.home.homeDirectory}/.config/mopidy/mopidy.conf";
			mode = "0400";
		};
	};

	home.file = {
		# ".config/mopidy/" = {
		# 	source = "${musicConfigs}/mopidy/";
		# 	recursive = true;
		# };

		".config/ncmpcpp/" = {
			source = "${musicConfigs}/ncmpcpp/";
			recursive = true;
		};

		#".config/MusicBrainz/" = {
		#	source = "${musicConfigs}/picard/";
		#	recursive = true;
		#};

	};
}
