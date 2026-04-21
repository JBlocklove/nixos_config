{ config, pkgs, inputs, lib, ... }:

let
	browserConfigs = ./configs/browser;
in {

#######################################
# setup librewolf (transient browser) #
#######################################

	programs.librewolf = {
		enable  = true;
		package = pkgs.librewolf.override {
			nativeMessagingHosts = [ pkgs.tridactyl-native ];
		};

		profiles.jason = {
			# — bookmarks
			bookmarks.force    = true;
			bookmarks.settings = [
			{
				name    = "Noogle";
				tags    = [ "nix" ];
				keyword = "noogle";
				url     = "https://noogle.dev";
			}
			];

			# prefs
			settings = {
				"browser.startup.homepage" = "https://dash.blocklove.net/";
				"browser.download.start_downloads_in_tmp_dir" = true;
				"browser.download.useDownloadDir" = false;
				"browser.urlbar.placeholderName" = "DuckDuckGo";
				"browser.urlbar.placeholderName.private" = "DuckDuckGo";
				"toolkit.legacyUserProfileCustomizations.stylesheets" = true;

				# fingerprinting protection (FPP) timezone override
                "privacy.resistFingerprinting" = false;
                "privacy.fingerprintingProtection" = true;
                "privacy.fingerprintingProtection.pbmode" = true;
                "privacy.fingerprintingProtection.overrides" = "+AllTargets,-JSDateTimeUTC";
			};

			# extensions
			extensions.packages =
				with inputs.firefox-addons.packages."x86_64-linux"; [
					ublock-origin
					cookies-txt
					return-youtube-dislikes
					tridactyl
					youtube-shorts-block
					tab-session-manager
					darkreader
				];

			# userChrome.css
			userChrome = builtins.readFile "${browserConfigs}/librewolf/userChrome.css";
		};
	};

############################################
# symlink real config files into ~/.config #
############################################
	home.file = {
		".config/tridactyl/" = {
			source = "${browserConfigs}/tridactyl/";
			recursive = true;
		};
	};

}
