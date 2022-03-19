{ config, ... }: {
  xsession.windowManager.bspwm = {
    enable = true;
    monitors = {
        DP-1 = ["1" "2" "3" "4" "5"];
	HDMI-1 = ["6" "7" "8" "9" "0"];
    };
    settings = {
      window_gap = 12;
      border_width = 2;
      split_ratio = 0.52;
      top_padding = 24;
      normal_border_color = "#474546";
      focused_border_color = "#87ceeb";
    };
    extraConfig = ''
      feh --no-fehbg --bg-fill ${config.xdg.configHome}/xorg/wallpaper.png
      systemctl --user restart polybar # home-manager loads this too early
    '';
  };
}
