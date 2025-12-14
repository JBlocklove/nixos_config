{ pkgs, inputs, ...}: {

	imports = [
		inputs.sops-nix.nixosModules.sops
	];

	sops.age.keyFile = "/home/jason/.config/sops/age/keys.txt";
}
