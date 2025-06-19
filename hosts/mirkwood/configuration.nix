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

	## Custom nixos configs
	hypr.enable = true;
	gaming.enable = false;
	communication.enable = true;
	engineering.enable = true;
	term.enable = true;
	audio.enable = true;


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

	system.stateVersion = "24.11";

	services.logind = {
		lidSwitch = "suspend-then-hibernate";
		lidSwitchExternalPower = "suspend-then-hibernate";
		extraConfig = ''
			HandleLidSwitch=suspend-then-hibernate
		'';
	};

	systemd.sleep.extraConfig = ''
		HibernateDelaySec=30m
	'';


	powerManagement.enable = true;
	services.thermald.enable = true;

	services.tlp = {
		enable = true;
		settings = {
			CPU_SCALING_GOVERNOR_ON_AC = "performance";
			CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

			CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
			CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

			#Optional helps save long term battery health
			START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
			STOP_CHARGE_THRESH_BAT0 = 90; # 80 and above it stops charging

		};
	};

	programs.light.enable = true;


	## Lock on resume
	systemd.services = {
		lock-before-sleeping = {
			restartIfChanged = false;

			unitConfig = {
				Description = "Helper service to bind locker to sleep.target";
			};
			serviceConfig = {
				User = "jason";
				ExecStart = "/run/current-system/sw/bin/hyprlock";
				Type = "simple";
			};
			before = [
				"pre-sleep.service"
			];
			wantedBy = [
				"pre-sleep.service"
			];
			environment = {
				WAYLAND_DISPLAY = "wayland-1";
				XDG_RUNTIME_DIR = "/run/user/1000";
			};
		};
	};

	## Auditing for home dir mkdirs
	security.auditd.enable = true;
	security.audit.enable = true;
	security.audit.failureMode = "printk";
	security.audit.backlogLimit = 8192;
	security.audit.rules = [
		"-a always,exit -F arch=b64 -S mkdir,mkdirat -F dir=/home/jason -k home_mkdir"
	];
	services.journald.audit = true;

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
