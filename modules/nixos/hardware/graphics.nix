{ pkgs, ... }: {
    hardware.graphics = {
        enable = true;
        enable32Bit = true;
    };
    hardware.acpilight.enable = true; # Backlight support
}
