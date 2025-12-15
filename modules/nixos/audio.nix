{ config, pkgs, lib, ... }: {

	options = {
		audio.enable = lib.mkEnableOption "enables audio stuff programs";
	};

	config = lib.mkIf config.audio.enable {

		environment.systemPackages = with pkgs; [
			pavucontrol
			qpwgraph
			alsa-utils
			noisetorch
			ncmpcpp
			mpc
			gst_all_1.gstreamer
			gst_all_1.gst-plugins-base
			gst_all_1.gst-plugins-good
			gst_all_1.gst-plugins-bad
			gst_all_1.gst-plugins-ugly
			gst_all_1.gst-libav
			gst_all_1.gst-devtools
			gst_all_1.gstreamermm
		];

		security.rtkit.enable = true;

		services.pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
			jack.enable = true;
		};

		security.wrappers.noisetorch = {
			source = "${pkgs.noisetorch}/bin/noisetorch";
			owner = "root";
			group = "root";
			capabilities = "cap_sys_resource+ep";
		};
	};
}
