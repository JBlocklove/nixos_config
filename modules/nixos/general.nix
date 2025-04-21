{ config, pkgs, lib, ... }: {

  options = {
    general.enable = lib.mkEnableOption "enables general system setup options";
  };

  config = lib.mkIf config.general.enable {

	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;
	services.blueman.enable = true;

    environment.systemPackages = with pkgs; [
	  gcc
	  gparted
	  pass
	  nodejs #need npm for lsp in nvim
	  rofi-wayland
	  wl-clipboard
	  imagemagick
	  sxiv
	  grim
	  slurp
	  swappy
	  zoom-us
	  pinta
	  python3
    ];

	programs.gnupg.agent.enable = true;

	services.flatpak.enable = true;

	services.udisks2.enable = true;
	services.udev.extraRules = ''
    	# UDISKS_FILESYSTEM_SHARED == 1: mount filesystem to a shared directory
    	ENV{ID_FS_USAGE}=="filesystem|other|crypto", ENV{UDISKS_FILESYSTEM_SHARED}="1"
	'';
	systemd.tmpfiles.rules = [
		"d /media 0755 root root - -"
	];
  };
}
