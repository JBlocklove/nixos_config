{ pkgs, ... }: {

	services.jellyfin = {
		enable = true;
		openFirewall = true;
	};
	users.users.jellyfin.extraGroups = [ "video" "render" ];

	environment.systemPackages = with pkgs; [
		jellyfin
		jellyfin-ffmpeg
	];

}

