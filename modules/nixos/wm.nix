{ config, pkgs, ... }: {
    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };

    # Screen sharing fix
    systemd.user.targets.hyprland-session = {
        description = "Hyprland session";
        bindsTo = [ "graphical-session.target" ];
        wants = [ "graphical-session-pre.target" ];
        after = [ "graphical-session-pre.target" ];
    };

    xdg.portal = {
        enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

        # Fallback routing for when $XDG_CURRENT_DESKTOP doesn't resolve to a
        # matching hyprland-portals.conf
        config.common = {
            default = [
                "hyprland"
                "gtk"
            ];
            "org.freedesktop.impl.portal.ScreenCast" = [ "hyprland" ];
            "org.freedesktop.impl.portal.Screenshot" = [ "hyprland" ];
            "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
        };
    };

    environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
    };
    environment.variables = {
        QT_QPA_PLATFORMTHEME = "gtk3";
    };

    services.upower.enable = true;
}
