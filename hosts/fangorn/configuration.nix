# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
			./hardware-configuration.nix
			inputs.home-manager.nixosModules.default
			./../../modules/nixos/default.nix
		];

# Boot stuff
	boot = {
		loader = {
			systemd-boot.enable = true;
			efi.canTouchEfiVariables = true;
		};

		initrd.kernelModules = [ "amdgpu" "coretemp" ];
	};

	networking.hostName = "fangorn"; # Define your hostname.

# Enable networking
		networking.networkmanager.enable = true;

# Set your time zone.
	time.timeZone = "America/New_York";

# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_US.UTF-8";
		LC_IDENTIFICATION = "en_US.UTF-8";
		LC_MEASUREMENT = "en_US.UTF-8";
		LC_MONETARY = "en_US.UTF-8";
		LC_NAME = "en_US.UTF-8";
		LC_NUMERIC = "en_US.UTF-8";
		LC_PAPER = "en_US.UTF-8";
		LC_TELEPHONE = "en_US.UTF-8";
		LC_TIME = "en_US.UTF-8";
	};

	services.getty.autologinUser = "jason";

# Configure keymap in X11
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};

# Environment variables
	environment.variables = {
		EDITOR = "nvim";
		VISUAL = "nvim";
	};

# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.jason = {
		isNormalUser = true;
		description = "Jason";
		extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
		packages = with pkgs; [];
	};

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

# List packages installed in system profile. To search, run:
# $ nix search wget
	environment.systemPackages = with pkgs; [
		neovim
		wget
		git
		alacritty
		firefox
		zsh
		stow
		htop
		lm_sensors
		fanctl
		ripgrep
		xdg-desktop-portal-hyprland
	];

	home-manager = {
		extraSpecialArgs = { inherit inputs; };
		users = {
			"jason" = import ./home.nix;
		};
	};



	programs.neovim = {
		enable = true;
		defaultEditor = true;
	};

	programs.zsh.enable = true;
	users.defaultUserShell = pkgs.zsh;

	hardware.graphics = {
		enable = true;
		enable32Bit = true;
	};


	hypr.enable = true;
	gaming.enable = true;
	communication.enable = true;
	engineering.enable = true;
	term.enable = true;
	audio.enable = true;


	fileSystems."/mnt/games" = {
		device = "/dev/disk/by-uuid/a7b7277d-b66e-4290-b58f-48262370b9ea";
		fsType = "ext4";
		mountPoint = "/mnt/games";
		options = [ "defaults" ];
		neededForBoot = false;
	};


	security.sudo = {
		enable = true;
		extraRules = [{
			commands = [
			{
				command = "/run/current-system/sw/bin/systemctl suspend";
				options = [ "NOPASSWD" ];
			}
			{
				command = "/run/current-system/sw/bin/reboot";
				options = [ "NOPASSWD" ];
			}
			{
				command = "/run/current-system/sw/bin/shutdown now";
				options = [ "NOPASSWD" ];
			}
			];
			groups = [ "wheel" ];
		}];
		extraConfig = with pkgs; ''
			Defaults:picloud secure_path="${lib.makeBinPath [
				systemd
			]}:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"
		'';
	};

services.openssh = {
	enable = true;
	ports = [ 8222 ];
	settings = {
		PasswordAuthentication = false;
		AllowUsers = null;
		UseDns = true;
		X11Forwarding = true;
		PermitRootLogin = "no";
	};
};

	system.stateVersion = "24.11"; # Did you read the comment?


	#systemd.user.services.mopidy = {
	#	description = "Mopidy user service";
	#	after = [ "network-online.target" ];
	#	wantedBy = [ "default.target" ];
	#	serviceConfig = {
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

	services.printing = {
		enable = true;
		browsing = true;
		drivers = with pkgs; [
			gutenprint
			hplipWithPlugin
		];
	};
	services.avahi = {
		enable = true;
		nssmdns4 = true;
		openFirewall = true;
	};

}
