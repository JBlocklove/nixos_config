{ pkgs, lib, ... }: {

	imports = [
		./general.nix
			./font-setup.nix
			./gaming.nix
			./engineering.nix
			./communication.nix
			./wm.nix
			./terminal.nix
			./audio.nix
			./xilinx.nix
			./video.nix
	];

	general.enable = lib.mkDefault true;
	gaming.enable = lib.mkDefault false;
	engineering.enable = lib.mkDefault false;
	communication.enable = lib.mkDefault true;
	hypr.enable = lib.mkDefault true;
	river.enable = lib.mkDefault false;
	term.enable = lib.mkDefault true;
	audio.enable = lib.mkDefault false;
	xilinx.enable = lib.mkDefault false;
	video.enable = lib.mkDefault true;
}
