{ pkgs, ... }: {

  # Container virtualization infrastructure
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  # System groups required for physical hardware programmers (JTAG, AVR, etc.)
  users.groups.plugdev = {};

  # Hardware rules
  services.udev.packages = with pkgs; [
    platformio-core
    openocd
  ];
}
