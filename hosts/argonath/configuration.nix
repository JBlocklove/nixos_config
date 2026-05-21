{ config, pkgs, inputs, ... }:

{
    imports = [
        ## Hardware setup
        ./hardware-configuration.nix
    ];

    # =========================================================================
    # Boot & Kernel Options
    # =========================================================================
    boot = {
        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };

        # kernelModules = [
        #     "amdgpu"
        #     "coretemp"
        # ];
    };

    # =========================================================================
    # Networking & Localization
    # =========================================================================
    networking.hostName = "argonath";
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

    nixpkgs.config.allowUnfree = false;


    # =========================================================================
    # Additional drive mounting
    # =========================================================================
    fileSystems."/media" = {
        device = "192.168.1.234:/mnt/user/data/media";
        fsType = "nfs";
        mountPoint = "/media";
        options = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=600" ];
    };


    # =========================================================================
    # Allow SSH remote access
    # =========================================================================
    services.openssh = {
        enable = true;
        ports = [ 8122 ];
        settings = {
            PasswordAuthentication = false;
            AllowUsers = null;
            UseDns = true;
            X11Forwarding = false;
            PermitRootLogin = "no";
        };
    };

    # Local network discovery
    services.avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
    };

  system.stateVersion = "25.11";

}
