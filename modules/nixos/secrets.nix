{ inputs, ...}: {

	imports = [
		inputs.sops-nix.nixosModules.sops
	];

    # FIXME: Move this? Or at least don't have it hardcoded
	sops.age.keyFile = "/home/jason/.config/sops/age/keys.txt";
}
