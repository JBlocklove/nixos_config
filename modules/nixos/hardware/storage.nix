{ pkgs, ... }: {
    services.udisks2 = {
        enable = true;
        mountOnMedia = true;
    };
    systemd.tmpfiles.rules = [ "d /media 0755 root root - -" ];

    environment.systemPackages = with pkgs; [
        gparted
    ];
}

