{ config, pkgs, inputs, ... }:

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
        ../../modules/nixos/gaming.nix
    ];

    # =========================================================================
    # Boot & Kernel Options
    # =========================================================================
    boot = {
        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };

        kernelModules = [
            "amdgpu"
            "coretemp"
        ];
    };

    # =========================================================================
    # Networking & Localization
    # =========================================================================
    networking.hostName = "fangorn";
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
    # Additional drive mounting
    # =========================================================================
    fileSystems."/mnt/games" = {
        device = "/dev/disk/by-uuid/a7b7277d-b66e-4290-b58f-48262370b9ea";
        fsType = "ext4";
        mountPoint = "/mnt/games";
        options = [ "defaults" ];
        neededForBoot = false;
    };


    # =========================================================================
    # Allow SSH remote access
    # =========================================================================
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

    # Local network discovery
    services.avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
    };

    system.stateVersion = "24.11";
}
