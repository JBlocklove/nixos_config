{ pkgs, ... }: {

    programs.steam = {
        enable = true;
    };

    environment.systemPackages = with pkgs; [
		steam
		# lutris
		# heroic
    ];
}

