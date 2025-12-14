{ config, pkgs, lib, ... }: {

	imports = [
		./secrets.nix
	];

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
			yarn
			rofi
			wl-clipboard
			imagemagick
			sxiv
			grim
			slurp
			swappy
			zoom-us
			pinta
			python3
			unzip
			wdisplays
			zathura
			nix-index
			w3m
			sops
			nix-output-monitor
			nvd
			nh
			libsecret
		];

		environment.sessionVariables = {
			NH_FLAKE = "/home/jason/nixos";
		};

		programs.gnupg.agent.enable = true;
		services.passSecretService.enable = true;

		services.flatpak.enable = true;

		services.udisks2.enable = true;
		services.udev.extraRules = ''
# UDISKS_FILESYSTEM_SHARED == 1: mount filesystem to a shared directory
ENV{ID_FS_USAGE}=="filesystem|other|crypto", ENV{UDISKS_FILESYSTEM_SHARED}="1"
		'';
		systemd.tmpfiles.rules = [
			"d /media 0755 root root - -"
		];


		programs.nix-ld = {
			enable = true;
			libraries = with pkgs; [
				glibc
				libgcc
			];
		};

	};

}
