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

		kernelParams = [
			"resume=/dev/disk/by-uuid/01962e0a-0daa-4750-a10d-366614a738d6"
		];

		kernelModules = [
			"thunderbolt"
			"usbcore"
			"usbhid"
		];

	};

	services.udev.extraRules = ''
		# Thunderbolt authorization (if needed)
		ACTION=="add", SUBSYSTEM=="thunderbolt", ATTR{authorized}=="0", ATTR{authorized}="1"
	'';

	networking.hostName = "mirkwood"; # Define your hostname.

	# Enable networking
	networking.networkmanager.enable = true;
	programs.nm-applet.enable = true;

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

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.jason = {
		isNormalUser = true;
		description = "Jason";
		extraGroups = [ "networkmanager" "wheel" "video" "audio" "dialout" ];
		packages = with pkgs; [];
	};

	home-manager = {
		extraSpecialArgs = { inherit inputs; };
		users = {
			"jason" = import ./home.nix;
		};
	};

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	# System-specific packages
	environment.systemPackages = with pkgs; [
		lm_sensors
		fanctl
	];

	## Custom nixos configs
	general.enable = true;
	gui.enable = true;
	hypr.enable = true;
	gaming.enable = false;
	communication.enable = true;
	engineering.enable = true;
	term.enable = true;
	audio.enable = true;
	xilinx.enable = true; # FIXME: Does this do anything anymore?


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
		/* extraConfig = with pkgs; ''
			# keep your secure_path for user “picloud”
    		Defaults:picloud secure_path="${lib.makeBinPath [ systemd ]}:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"

    		# preserve X11 / Wayland env so GUI apps can connect to your display
    		Defaults env_keep += "DISPLAY XAUTHORITY XDG_RUNTIME_DIR WAYLAND_DISPLAY WAYLAND_SOCKET"
		''; */
	};


	services.logind = {
		settings.Login = {
			HandleLidSwitch = "suspend-then-hibernate";
			HandleLidSwitchExternalPower = "suspend-then-hibernate";
		};
	};

	systemd.sleep.extraConfig = ''
		HibernateDelaySec=30m
	'';

	powerManagement.enable = true;
	powerManagement.powertop.enable = true;

	services.thermald.enable = true;

	services.tlp = {
		enable = true;
	};

	services.avahi = {
		enable = true;
		nssmdns4 = true;
		openFirewall = true;
	};


	system.stateVersion = "24.11";

}
