{ config, pkgs, lib, ... }: {

  options = {
    engineering.enable = lib.mkEnableOption "enables engineering programs";
  };

  config = lib.mkIf config.engineering.enable {
    environment.systemPackages = with pkgs; [
		# CAD
		freecad-wayland
		prusa-slicer

		# PCB
		kicad
		platformio
		avrdude

		# Digital hardware
		yosys
		xdot
		iverilog
		verilator
		distrobox
		#dsview

		# Etc.
		podman-tui
    ];

	services.udev.packages = with pkgs; [
		platformio-core
		openocd
	];

	virtualisation.podman= {
		enable = true;
		dockerCompat = true;
	};
  };
}


