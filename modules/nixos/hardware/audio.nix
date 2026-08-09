{ pkgs, ... }: {

    security.rtkit.enable = true;

    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
		wireplumber.enable = true;
    };

    security.wrappers.noisetorch = {
        source = "${pkgs.noisetorch}/bin/noisetorch";
        owner = "root";
        group = "root";
        capabilities = "cap_sys_resource+ep";
    };

    environment.systemPackages = with pkgs; [
        alsa-utils
        noisetorch

        # These require a GUI but that's fine
        pavucontrol
        qpwgraph
    ];
}
