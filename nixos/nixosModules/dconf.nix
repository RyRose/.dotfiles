{
  lib,
  ...
}:

{
  programs.dconf = {
    enable = true;
    profiles.user.databases = [
      {
        lockAll = true;
        settings = {
          "org/gnome/settings-daemon/plugins/media-keys" = {
            custom-keybindings = [
              "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
            ];
          };
          "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
            binding = "<Super>t";
            command = "ghostty";
            name = "Ghostty";
          };
          "org/gnome/shell/extensions/pop-shell" = {
            toggle-tiling = [ "<Super>y" ];
            toggle-floating = [ "<Super>g" ];
            tile-enter = [ "<Super>Return" ];
            tile-accept = [ "Return" ];
            tile-reject = [ "Escape" ];
            toggle-stacking-global = [ "<Super>s" ];
            pop-workspace-down = lib.gvariant.mkEmptyArray (lib.gvariant.type.string);
            pop-workspace-up = lib.gvariant.mkEmptyArray (lib.gvariant.type.string);
            pop-monitor-left = [
              "<Shift><Super>Left"
              "<Shift><Super>h"
            ];
            pop-monitor-right = [
              "<Shift><Super>Right"
              "<Shift><Super>l"
            ];
            pop-monitor-down = lib.gvariant.mkEmptyArray (lib.gvariant.type.string);
            pop-monitor-up = lib.gvariant.mkEmptyArray (lib.gvariant.type.string);
            focus-left = [
              "<Super>Left"
              "<Super>h"
            ];
            focus-down = [
              "<Super>Down"
              "<Super>j"
            ];
            focus-up = [
              "<Super>Up"
              "<Super>k"
            ];
            focus-right = [
              "<Super>Right"
              "<Super>l"
            ];
          };

          "org/gnome/desktop/wm/keybindings" = {
            close = [
              "<Super>q"
              "<Alt>F4"
            ];
            minimize = [ "<Super>comma" ];
            toggle-maximized = [ "<Super>m" ];
            move-to-monitor-left = lib.gvariant.mkEmptyArray (lib.gvariant.type.string);
            move-to-monitor-right = lib.gvariant.mkEmptyArray (lib.gvariant.type.string);
            move-to-monitor-up = lib.gvariant.mkEmptyArray (lib.gvariant.type.string);
            move-to-monitor-down = lib.gvariant.mkEmptyArray (lib.gvariant.type.string);
            move-to-workspace-down = lib.gvariant.mkEmptyArray (lib.gvariant.type.string);
            move-to-workspace-up = lib.gvariant.mkEmptyArray (lib.gvariant.type.string);

            move-to-workspace-left = [ "<Ctrl><Super>h" ];
            move-to-workspace-right = [ "<Ctrl><Super>l" ];
            switch-to-workspace-left = [ "<Alt><Super>h" ];
            switch-to-workspace-right = [ "<Alt><Super>l" ];

            switch-to-workspace-down = lib.gvariant.mkEmptyArray (lib.gvariant.type.string);
            switch-to-workspace-up = lib.gvariant.mkEmptyArray (lib.gvariant.type.string);
            maximize = lib.gvariant.mkEmptyArray (lib.gvariant.type.string);
            unmaximize = lib.gvariant.mkEmptyArray (lib.gvariant.type.string);
          };

          "org/gnome/desktop/interface" = {
            clock-format = "12h";
            color-scheme = "prefer-dark";
          };
        };
      }
    ];
  };
}
