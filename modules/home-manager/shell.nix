{ config, pkgs, lib, ... }:

let
	shellConfigs = ./configs/shell;

	gitScripts = pkgs.runCommand "git-scripts" {} ''
		mkdir -p $out/bin
		cp -r ${shellConfigs}/git/local/* $out/bin/
		chmod +x $out/bin/*
	'';
in
{
#####################
# install packages  #
#####################
	home.packages = with pkgs; [
		tmux
		ranger
		htop
		git
		gitScripts
        ripgrep
        bat
        procs
        lsd
        unzip
	];

	programs.zsh = {
		enable  = true;
		dotDir = ".config/zsh";
	};

#######################################
# symlink config files into ~/.config #
#######################################
	home.file = {
		".config/git/" = {
			source = "${shellConfigs}/git/config";
			recursive = true;
		};

		".config/zsh/" = {
			source = "${shellConfigs}/zsh/";
			recursive = true;
		};

		".config/tmux/" = {
			source = "${shellConfigs}/tmux/";
			recursive = true;
		};

		".config/ranger/" = {
			source = "${shellConfigs}/ranger/";
			recursive = true;
		};

		".config/htop/" = {
			source = "${shellConfigs}/htop/";
			recursive = true;
		};
	};
}
