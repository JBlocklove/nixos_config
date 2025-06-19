{ config, pkgs, lib, inputs, ... }: {

  options = {
    term.enable = lib.mkEnableOption "enables my usual terminal programs";
  };

  config = lib.mkIf config.term.enable {
    environment.systemPackages = with pkgs; [
		alacritty
		alacritty.terminfo
		khard
		vdirsyncer
		ranger
		ueberzugpp
		ncmpcpp
		lsd
	  	tmux
		bat
		procs
		#inputs."khal-git".packages."x86_64-linux"."khal-git"
		khal
    ];
  };
}



