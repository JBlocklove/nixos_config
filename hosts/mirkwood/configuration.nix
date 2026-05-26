{ pkgs, inputs, ... }:

{
    imports = [
        ## Hardware setup
        ./hardware-configuration.nix
        ../../modules/nixos/hardware/audio.nix
        ../../modules/nixos/hardware/bluetooth.nix
        ../../modules/nixos/hardware/graphics.nix
        ../../modules/nixos/hardware/printing.nix
        ../../modules/nixos/hardware/storage.nix

        ## Window manager setup
        ../../modules/nixos/wm/hyprland.nix

        ## Additional nixos modules
        ../../modules/nixos/fonts.nix
        ../../modules/nixos/engineering.nix
        ../../modules/nixos/secrets.nix
    ];

    # =========================================================================
    # Boot & Kernel Options
    # =========================================================================
    boot = {
        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };

        # Hibernation resume partition (swap)
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

    # Udev rules to work with thunderbolt dock
    services.udev.extraRules = ''
    # Thunderbolt authorization
    ACTION=="add", SUBSYSTEM=="thunderbolt", ATTR{authorized}=="0", ATTR{authorized}="1"
    '';

    # =========================================================================
    # Networking & Localization
    # =========================================================================
    networking.hostName = "mirkwood";
    networking.networkmanager.enable = true;

    time.timeZone = "America/New_York";

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

    services.xserver.xkb = {
        layout = "us";
        variant = "";
    };

    # =========================================================================
    # User Account Space
    # =========================================================================
    services.getty.autologinUser = "jason";

    users.users.jason = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" "video" "audio" "dialout" "plugdev" ];
    };

    home-manager = {
        extraSpecialArgs = { inherit inputs; };
        useGlobalPkgs = true;
        useUserPackages = true;
        users = {
            "jason" = import ./home.nix;
        };
    };

    nixpkgs.config.allowUnfree = true;

    # =========================================================================
    # Power Management & Laptop Sleep Quirks
    # =========================================================================
    powerManagement.enable = true;
    powerManagement.powertop.enable = true;
    services.thermald.enable = true;
    services.power-profiles-daemon.enable = true;

    services.logind = {
        settings.Login = {
            HandleLidSwitch = "suspend-then-hibernate";
            HandleLidSwitchExternalPower = "suspend-then-hibernate";
            HandleLidSwitchDocked = "ignore";
        };
    };

    systemd.sleep.settings.Sleep = { 
        HibernateDelaySec = "15m"; 
    };

    # Lock screen automatically before the laptop goes to sleep
    systemd.services.lock-before-sleeping = {
        restartIfChanged = false;
        unitConfig.Description = "Helper service to bind locker to sleep.target";

        serviceConfig = {
            User = "jason";
            Type = "simple";
            # Using direct store path instead of an impure system path
            ExecStart = "/etc/profiles/per-user/jason/bin/noctalia-shell ipc call lockScreen lock";
            ExecStartPost = "/run/current-system/sw/bin/sleep 0.3";
        };

        before = [ "sleep.target" ];
        wantedBy = [ "sleep.target" ];

        environment = {
            WAYLAND_DISPLAY = "wayland-1";
            XDG_RUNTIME_DIR = "/run/user/1000";
        };
    };

    # Local network discovery
    services.avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
    };

    system.stateVersion = "24.11";
}
