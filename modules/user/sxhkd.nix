{ config, pkgs, ... }:
let
  super = "Mod4";
  alt = "Mod1";
in {
  services.sxhkd = {
    enable = true;
    keybindings = {
      # alacritty (Terminal)
      "super + return" = "alacritty";

      # Dunst (Notification daemon)
      "super + grave" = "dunstctl history-pop";

      # Rofi (App launcher)
      "super + d" = "rofi -lines 12 -padding 18 -width 60 -location 0 -show drun -sidebar-mode -columns 3 -font 'Noto Sans 8'";

      # Printscreen
      "{shift,_} + Print" = "maim -u{s,} | xclip -selection clipboard -t image/png";

      # Quick-kill picom
      "super + p" = "mpc toggle";

      # Volume
      "Super + {Shift + =,-}" = "mpc volume {+5,-5}";

      # Kill focused window
      "super + {_,shift + }q" = "bspc node -{c,k}";

      # Change focus
      "super + {h,j,k,l}" = "bspc node -f {west,south,north,east}";
      "super + {Left,Down,Up,Right}" = "bspc node -f {west,south,north,east}";

      # Switch windows
      "super + shift + {h,j,k,l}" = "bspc node -s {west,south,north,east}";
      "super + shift + {Left,Down,Up,Right}" = "bspc node -s {west,south,north,east}";

      # Move focused window
      "super + shift + {1-9,0}" = "bspc node -d ^{1-9,10}";

      # Toggle tiled/fullscreen/floating
      "super + {t,f,s}" = "bspc node -t '~{tiled,fullscreen,floating}'";

      # Exit / Restart bspwm
      "super + shift + {q,r}" = "bspc {quit,wm -r}";

      # Restart sxhkd
      "super + shift + s" = "pkill -USR1 -x sxhkd";

      # Workspace switching
      "super + {1-9,0}" = "bspc desktop -f ^{1-9,10}";
    };
  };
}
