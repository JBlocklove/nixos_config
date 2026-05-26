{ pkgs, inputs, ... }: {

    # Enabling things that probably shouldn't still be experimental...
    nix.settings.experimental-features = [ "nix-command" "flakes" ];


    # System-wide shell setup
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;

    environment.systemPackages = with pkgs; [
        git
        wget
        curl
        sops
        nh
        nvd
        nix-output-monitor
        libsecret
        inputs.nix-neovim.packages.${pkgs.stdenv.hostPlatform.system}.default
        pass
        lm_sensors
        fanctl
    ];

    # Automatic command-not-found database execution
    programs.nix-index-database.comma.enable = true;

    # System security setup
    programs.gnupg.agent.enable = true;
    services.passSecretService.enable = true;

    # Stuff to attempt to run unpatched dynamic binaries
    programs.nix-ld = {
        enable = true;
        libraries = with pkgs; [ glibc libgcc ];
    };

}
