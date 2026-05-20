{ pkgs, ... }: {

	#####################
	# install packages  #
	#####################
	home.packages = with pkgs; [
		texliveFull
		zathura
		zotero
        libreoffice
	];
}
