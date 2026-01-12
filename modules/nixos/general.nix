{ config, pkgs, lib, inputs, ... }: {

	imports = [
		./secrets.nix
	];

	options = {
		general.enable = lib.mkEnableOption "enables general system setup options";
		gui.enable = lib.mkEnableOption "enables GUI general system programs";
	};

	config = lib.mkMerge[

		(lib.mkIf config.general.enable {

			environment.sessionVariables = {
				NH_FLAKE = "/home/jason/nixos";
			};

			hardware.bluetooth.enable = true;
			hardware.bluetooth.powerOnBoot = true;
			services.blueman.enable = true;

			environment.systemPackages = with pkgs; [
				gcc
				gparted
				pass
				imagemagick
				python3
				unzip
				nix-index
				sops
				nix-output-monitor
				nvd
				nh
				libsecret
				wget
				git
				inputs.catvim.packages.${stdenv.hostPlatform.system}.default
				zsh
				htop
				stow # For now...
				ripgrep
			];

			programs.zsh.enable = true;
			users.defaultUserShell = pkgs.zsh;


			programs.gnupg.agent.enable = true;
			services.passSecretService.enable = true;

			services.flatpak.enable = true;

			programs.nix-ld = {
				enable = true;
				libraries = with pkgs; [
					glibc
					libgcc
				];
			};

		})
		(lib.mkIf ( config.general.enable && config.gui.enable ) {
			environment.systemPackages = with pkgs; [
				alacritty
				librewolf
				rofi
				w3m
				sxiv
				grim
				slurp
				swappy
				pinta
				wdisplays
				zathura
			];

			programs.light.enable = true;

			hardware.graphics = {
				enable = true;
				enable32Bit = true;
			};

			services.udisks2.enable = true;
			services.udev.extraRules = ''
				# UD_FILESYSTEM_SHARED == 1: mount filesystem to a shared directory
				ENV{S_USAGE}=="filesystem|other|crypto", ENV{UDISKS_FILESYSTEM_SHARED}="1"
			'';
			systemd.tmpfiles.rules = [
				"d /media 0755 root root - -"
			];

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

			services.printing = {
				enable = true;
				browsing = true;
				drivers = with pkgs; [
					gutenprint
					hplipWithPlugin
				];
			};


		})
	];
}
