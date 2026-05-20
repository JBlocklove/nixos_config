{ pkgs, inputs, ... }:

{
	imports =
		[
			./hardware-configuration.nix
			inputs.home-manager.nixosModules.default
			./../../modules/nixos/default.nix
		];

    ############################
    ## Boot and kernel params ##
    ############################
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
			"k10temp"
		];

	};

    ################
    ## Udev Rules ##
    ################
	services.udev.extraRules = ''
		# Thunderbolt authorization (if needed)
		ACTION=="add", SUBSYSTEM=="thunderbolt", ATTR{authorized}=="0", ATTR{authorized}="1"
	'';

    ################
    ## Networking ##
    ################
	networking.hostName = "mirkwood";

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

	# Configure keymap in X11
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};

    # Automatically log in to my user
	services.getty.autologinUser = "jason";

    # Managed further in home-manager
	users.users.jason = {
		isNormalUser = true;
		description = "Jason";
		extraGroups = [ "networkmanager" "wheel" "video" "audio" "dialout" "plugdev" ];
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
	xilinx.enable = false; # FIXME: Does this do anything anymore?


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
	};


	services.logind = {
		settings.Login = {
			HandleLidSwitch = "suspend-then-hibernate";
			HandleLidSwitchExternalPower = "suspend-then-hibernate";
			HandleLidSwitchDocked = "ignore";
		};
	};

	systemd.sleep.settings.Sleep = { HibernateDelaySec = "15m"; };

	## Lock on resume
	systemd.services = {
		lock-before-sleeping = {
			restartIfChanged = false;

			unitConfig = {
				Description = "Helper service to bind locker to sleep.target";
			};
			serviceConfig = {
				User = "jason";
				Type = "simple";
				ExecStart = "/run/current-system/sw/bin/noctalia-shell ipc call lockScreen lock";
				ExecStartPost = "${pkgs.coreutils}/bin/sleep 0.3";
			};
			before = [
				"sleep.target"
			];
			wantedBy = [
				"sleep.target"
			];
			environment = {
				WAYLAND_DISPLAY = "wayland-1";
				XDG_RUNTIME_DIR = "/run/user/1000";
			};
		};
	};

	powerManagement.enable = true;
	powerManagement.powertop.enable = true;

	services.thermald.enable = true;

	services.power-profiles-daemon = {
		enable = true;
	};

	services.avahi = {
		enable = true;
		nssmdns4 = true;
		openFirewall = true;
	};


	system.stateVersion = "24.11";

}
