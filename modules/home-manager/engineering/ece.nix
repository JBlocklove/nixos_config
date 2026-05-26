{ pkgs, ... }: {

#####################
# install packages  #
#####################
	home.packages = with pkgs; [
        # HDL
        ghdl
        iverilog
        verilator
        sv-lang
        yosys

        # Virtualization (needed for Vivado)
        distrobox
        podman-tui

        # PCB
        kicad

        # Embedded
        platformio
        avrdude
        minicom

	];

}




