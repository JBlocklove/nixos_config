{ pkgs, ... }: {

    security.rtkit.enable = true;

    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
		wireplumber.enable = true;
		# Trying to force better handling of my microphone
		extraConfig = {
			pipewire = {
				"default.clock.rate" = 48000;
			};
		};
    };

    security.wrappers.noisetorch = {
        source = "${pkgs.noisetorch}/bin/noisetorch";
        owner = "root";
        group = "root";
        capabilities = "cap_sys_resource+ep";
    };

	# Fixes noisetorch
	systemd.user.services.pipewire-pulse.environment = {
		LADSPA_PATH="/tmp:";
	};

    environment.systemPackages = with pkgs; [
        alsa-utils
        noisetorch

        # These require a GUI but that's fine
        pavucontrol
        qpwgraph
    ];
}
