{ ... }: {
    # Enabling the module sets up PAM and display manager hooks properly
    programs.river.enable = true; 

    services.upower.enable = true;

    environment.variables = {
        QT_QPA_PLATFORMTHEME = "gtk3";
    };
}

