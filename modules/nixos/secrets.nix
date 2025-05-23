{ pkgs, inputs, ...}: {

	imports = [
		inputs.sops-nix.nixosModules.sops
	];

	sops.defaultSopsFile = ../../secrets/secrets.yaml;
	sops.defaultSopsFormat = "yaml";

	sops.age.keyFile = "/home/jason/.config/sops/age/keys.txt";

	sops.secrets."mopidy/jellyfin/url" = { };
	sops.secrets."mopidy/jellyfin/username" = { };
	sops.secrets."mopidy/jellyfin/password" = { };

}
