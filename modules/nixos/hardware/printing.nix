{ pkgs, ... }: {

    services.printing = {
        enable = true;
        browsing = true;
        drivers = with pkgs; [
            gutenprint
            hplipWithPlugin
        ];
    };

}


