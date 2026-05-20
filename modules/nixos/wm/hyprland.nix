{ pkgs, ... }: {
    programs.hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;
    };

    xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    };

    services.upower.enable = true;

    environment.variables = {
        QT_QPA_PLATFORMTHEME = "gtk3";
    };
}
