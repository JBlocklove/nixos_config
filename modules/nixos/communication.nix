{ config, pkgs, lib, ... }: {

  options = {
    communication.enable = lib.mkEnableOption "enables messaging/email programs";
  };

  config = lib.mkIf config.communication.enable {
    environment.systemPackages = with pkgs; [
		signal-desktop
		vesktop
		slack
		#neomutt
		#notmuch
		#isync
		#msmtp
		khard
		zoom-us
    ];
  };
}



