{ config, pkgs, lib, ... }: {

	options = {
		xilinx.enable = lib.mkEnableOption "enables xilinx nonsense";
	};

	config = lib.mkIf config.xilinx.enable {

		environment.systemPackages = with pkgs; [
		];

		programs.nix-ld = {
			enable = true;
			libraries = with pkgs; [
				glib
				ncurses5
				zlib
				libuuid
				bash
				coreutils
				stdenv.cc.cc
				# X11 / GTK
				xorg.libX11
				xorg.libXext
				xorg.libXrender
				xorg.libXtst
				xorg.libXi
				xorg.libXft
				xorg.libxcb
				# font + graphics
				freetype
				fontconfig
				graphviz
				gtk2
				gtk3
				# tooling
				gcc
				unzip
			];
		};

	};

}

