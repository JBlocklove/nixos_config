{ config, pkgs, lib, inputs, ... }: {

  options = {
    term.enable = lib.mkEnableOption "enables my usual terminal programs";
  };

  config = lib.mkIf config.engineering.enable {
    environment.systemPackages = with pkgs; [
		khard
		vdirsyncer
		ranger
		ueberzug
		ncmpcpp
		lsd
	  	tmux
		bat
		procs
		inputs."khal-git".packages."x86_64-linux"."khal-git"
    ];
  };
}



