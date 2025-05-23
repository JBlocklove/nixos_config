{ config, pkgs, ... }:

let
	musicConfigs = ./configs/music;
in {

	home.packages = with pkgs; [
		#jellyfin-tui
		#ncmpcpp
		#mpc
	];

	#services.mopidy = {
	#	enable = true;
	#	extensionPackages = with pkgs; [
	#		mopidy-mpd
	#		mopidy-jellyfin
	#		mopidy-local
	#	];
	#	extraConfigFiles = [
	#		"${musicConfigs}/mopidy/mopidy.conf"
	#	];
	#};

	#systemd.user.services.mopidy = {
	#	Unit = {
	#		Description = "Mopidy user service";
	#		After = [ "network-online.target" ];
	#	};

	#	Install = {
	#		WantedBy = [ "default.target" ];
	#	};

	#	Service = {
	#		Type = "simple";

	#		ExecStart = ''
	#			${pkgs.nix}/bin/nix-shell \
	#			-p ${pkgs.mopidy} \
	#			${pkgs.mopidy-mpd} \
	#			${pkgs.mopidy-jellyfin} \
	#			--run "mopidy"
	#			'';
	#		Restart = "on-failure";

	#		Environment = "XDG_CONFIG_HOME=%h/.config";
	#	};
	#};



	#home.file = {
	#	".config/mopidy/" = {
	#		source = "${musicConfigs}/mopidy/";
	#		recursive = true;
	#	};

	#	".config/ncmpcpp/" = {
	#		source = "${musicConfigs}/ncmpcpp/";
	#		recursive = true;
	#	};

	#};
}
