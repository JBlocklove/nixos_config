{ config, pkgs, ... }:

{
  # Add Mopidy and plugins to your user's PATH
  home.packages = with pkgs; [
    (mopidyWithPlugins {
      plugins = p: [
        p.mopidy-jellyfin
        p.mopidy-mpd
      ];
    })
  ];

  # Create a user systemd service that runs Mopidy in the background
  systemd.user.services.mopidy = {
    description = "Mopidy user service";
    wantedBy = [ "default.target" ];
    after = [ "network-online.target" ];
    serviceConfig = {
      # ExecStart calls Mopidy normally;
      # Mopidy will read ~/.config/mopidy/mopidy.conf
      ExecStart = "${pkgs.mopidy}/bin/mopidy";

      # If you want Mopidy to log to a file in your home:
      # ExecStart = "${pkgs.mopidy}/bin/mopidy --save-debug-log /home/youruser/mopidy.log";

      # If you need environment variables, etc., you can set them here
      Environment = "XDG_CONFIG_HOME=%h/.config";
      # ...
    };
  };

  # Optionally, if you want to manage the actual config file via Home Manager:
  home.file.".config/mopidy/mopidy.conf".source = ./mopidy.conf;
}

