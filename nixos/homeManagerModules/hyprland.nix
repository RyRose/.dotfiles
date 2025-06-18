{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{

  options = {
    my.hyprland.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable hyprland.";
    };
    my.hyprland.monitors = lib.mkOption {
      type =
        with lib.types;
        listOf (submodule {
          options = {
            name = lib.mkOption {
              type = str;
              description = "The name of the output, e.g., DP-3 or HDMI-A-1.";
            };
            mode = lib.mkOption {
              type = nullOr str;
              default = null;
              description = "Resolution and refresh rate like '3440x1440@100'. Use null to disable.";
            };
            position = lib.mkOption {
              type = nullOr str;
              default = null;
              description = "Position like '0x0'. Only used if mode is not null.";
            };
            scale = lib.mkOption {
              type = nullOr str;
              default = null;
              description = "Scale factor like '1'. Only used if mode is not null.";
            };
          };
        });
      default = [
        {
          name = "";
          mode = "preferred";
          position = "auto";
          scale = "1";
        }
      ];
      description = ''
        Structured monitor configuration list. Mode = null means the monitor is disabled.
      '';
    };
  };

  config = lib.mkIf config.my.hyprland.enable {

    # Use personal styling for nvim instead of stylix.
    stylix.targets.neovim.enable = false;
    stylix.targets.nixvim.enable = false;
    stylix.targets.vim.enable = false;
    stylix.targets.neovide.enable = false;
    stylix.targets.nvf.enable = false;

    services.kdeconnect.enable = true;
    services.kdeconnect.indicator = true;
    services.kdeconnect.package = pkgs.kdePackages.kdeconnect-kde;

    services.playerctld.enable = true;

    wayland.windowManager.hyprland = {
      enable = true; # enable Hyprland

      # https://wiki.hyprland.org/Nix/Hyprland-on-Home-Manager/#using-the-home-manager-module-with-nixos
      # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
      package = null;
      portalPackage = null;

      # Use UWSM (Unified Wayland Session Manager) for Hyprland instead.
      systemd.enable = false;
    };

    wayland.windowManager.hyprland.settings = {

      source = "${inputs.catppuccin-hyprland}/themes/frappe.conf";

      monitor = map (
        m:
        if m.mode == null then "${m.name}, disable" else "${m.name}, ${m.mode}, ${m.position}, ${m.scale}"
      ) config.my.hyprland.monitors;

      ###################
      ### MY PROGRAMS ###
      ###################

      # See https://wiki.hyprland.org/Configuring/Keywords/

      # Set programs that you use
      "$uwsm" = "${lib.getExe pkgs.uwsm}";
      "$terminal" = "$uwsm app -- ${lib.getExe pkgs.ghostty}";
      "$fileManager" = "$uwsm app -- ${lib.getExe pkgs.xfce.thunar}";
      "$menu" =
        "$uwsm app -- ${lib.getExe pkgs.rofi-wayland} -show combi -modes combi -combi-modes 'drun,run' -show-icons";
      "$hyprshot" = "$uwsm app -- ${lib.getExe pkgs.hyprshot}";
      "$webBrowser" = "$uwsm app -- ${lib.getExe pkgs.firefox}";
      "$youtubeMusic" = "$uwsm app -- ${lib.getExe pkgs.youtube-music}";
      "$passwordManager" = "$uwsm app -- ${lib.getExe pkgs.bitwarden-desktop}";
      "$wlogout" = "$uwsm app -- ${lib.getExe pkgs.wlogout}";
      "$hyprlock" = "$uwsm app -- ${lib.getExe pkgs.hyprlock}";
      "$wpctl" = "$uwsm app -- ${lib.getExe' pkgs.wireplumber "wpctl"}";
      "$brightnessctl" = "$uwsm app -- ${lib.getExe pkgs.brightnessctl}";
      "$playerctl" = "$uwsm app -- ${lib.getExe pkgs.playerctl}";

      #################
      ### AUTOSTART ###
      #################

      # Autostart necessary processes (like notifications daemons, status bars, etc.)
      # Or execute your favorite apps at launch like this:

      exec-once =
        let
          startupScript = pkgs.pkgs.writeShellScriptBin "start" ''

            services=(
              blueman-applet
              dunst
              hypridle
              hyprpolkitagent
              kdeconnect
              kdeconnect-indicator
              waybar
            )

            for svc in "${"$"}{services[@]}"; do
              systemctl --user is-enabled "$svc" >/dev/null 2>&1 || systemctl --user enable "$svc"
              systemctl --user is-active "$svc"  >/dev/null 2>&1 || systemctl --user start "$svc"
            done &

            ${lib.getExe pkgs.uwsm} app -- ${lib.getExe pkgs.swww} init &
            ${lib.getExe pkgs.uwsm} app -- ${lib.getExe pkgs.swww} img ${../assets/wallpapers/davidcohen-EhSxbBCjr9A-unsplash.jpg} &
            ${lib.getExe pkgs.uwsm} app -- ${lib.getExe pkgs.networkmanagerapplet} &
          '';
        in
        ''${startupScript}/bin/start'';

      #####################
      ### LOOK AND FEEL ###
      #####################

      # Refer to https://wiki.hyprland.org/Configuring/Variables/

      # https://wiki.hyprland.org/Configuring/Variables/#general
      general = {
        gaps_in = 2;
        gaps_out = 10;
        border_size = 2;
      };

      # https://wiki.hyprland.org/Configuring/Variables/#decoration
      decoration = {
        rounding = 10;
        rounding_power = 2;
      };

      # https://wiki.hyprland.org/Configuring/Variables/#animations
      animations = {
        enabled = true;

        # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
      dwindle = {
        pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mod + P in the keybinds section below
        preserve_split = true; # You probably want this
      };

      # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
      master.new_status = "master";

      ###################
      ### KEYBINDINGS ###
      ###################

      # See https://wiki.hyprland.org/Configuring/Keywords/
      "$mod" = "SUPER"; # Sets "Windows" key as main modifier

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = [

        # Programs
        "$mod, T, exec, $terminal"
        "$mod CTRL, Q, exec, $wlogout"
        "$mod SHIFT, Q, exec, $hyprlock"
        "$mod, S, exec, $hyprshot -m region --clipboard-only" # Mac screenshot hotkey
        "$mod SHIFT, S, exec, $hyprshot -m region -o '${config.xdg.userDirs.pictures}/hyprshot'" # Mac screenshot hotkey
        "$mod, Y, exec, $youtubeMusic"
        "$mod, W, exec, $webBrowser"
        "$mod, P, exec, $passwordManager"
        "$mod, grave, exec, $uwsm stop"
        "$mod, F, exec, $fileManager" # Pop OS hotkey
        "$mod, Space, exec, $menu"

        # Misc window management
        "$mod, G, togglefloating," # Pop OS hotkey
        "$mod, I, pseudo," # dwindle
        "$mod, O, togglesplit, " # dwindle, Pop OS hotkey
        "$mod, Q, killactive," # Pop OS hotkey
        "$mod, M, fullscreen, 1"

        # Move focus with mod + arrow keys
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"

        # Move active window with mod + arrow keys
        "$mod SHIFT, h, movewindow, l"
        "$mod SHIFT, l, movewindow, r"
        "$mod SHIFT, k, movewindow, u"
        "$mod SHIFT, j, movewindow, d"

        # Switch workspaces with mod + [0-9]
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move active window to a workspace with mod + SHIFT + [0-9]
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # Scroll through existing workspaces with mod + scroll
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
      ];

      binde = [
        # Resize active window with mod + SHIFT + arrow keys
        "$mod CTRL, h, resizeactive, -20 0"
        "$mod CTRL, j, resizeactive, 0 20"
        "$mod CTRL, k, resizeactive, 0 -20"
        "$mod CTRL, l, resizeactive, 20 0"
      ];

      # Move/resize windows with mod + LMB/RMB and dragging
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # Laptop multimedia keys for volume and LCD brightness
      bindel = [
        ",XF86AudioRaiseVolume, exec, $wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, $wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, $wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, $wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, $brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, $brightnessctl -e4 -n2 set 5%-"
      ];

      # Requires playerctl
      bindl = [
        ",XF86AudioNext, exec, $playerctl next"
        ",XF86AudioPause, exec, $playerctl play-pause"
        ",XF86AudioPlay, exec, $playerctl play-pause"
        ",XF86AudioPrev, exec, $playerctl previous"
      ];

      ##############################
      ### WINDOWS AND WORKSPACES ###
      ##############################

      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      # See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules

      workspace = [
        # Smart gaps.
        "w[tv1], gapsout:0, gapsin:0"
        "f[1], gapsout:0, gapsin:0"

        # Pin workspaces 1-9 to first monitor.
        "1, monitor:${(lib.elemAt config.my.hyprland.monitors 0).name}"
        "2, monitor:${(lib.elemAt config.my.hyprland.monitors 0).name}"
        "3, monitor:${(lib.elemAt config.my.hyprland.monitors 0).name}"
        "4, monitor:${(lib.elemAt config.my.hyprland.monitors 0).name}"
        "5, monitor:${(lib.elemAt config.my.hyprland.monitors 0).name}"
        "6, monitor:${(lib.elemAt config.my.hyprland.monitors 0).name}"
        "7, monitor:${(lib.elemAt config.my.hyprland.monitors 0).name}"
        "8, monitor:${(lib.elemAt config.my.hyprland.monitors 0).name}"
        "9, monitor:${(lib.elemAt config.my.hyprland.monitors 0).name}"

        # Pin workspace 10 to second monitor.
        "10, monitor:${(lib.elemAt config.my.hyprland.monitors 1).name}"
      ];

      windowrule = [
        # Ignore maximize requests from apps. You'll probably like this.
        "suppressevent maximize, class:.*"
        # Fix some dragging issues with XWayland
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        # Smart gaps.
        "bordersize 0, floating:0, onworkspace:w[tv1]"
        "rounding 0, floating:0, onworkspace:w[tv1]"
        "bordersize 0, floating:0, onworkspace:f[1]"
        "rounding 0, floating:0, onworkspace:f[1]"
      ];
    };

    programs.waybar.enable = true;
    stylix.targets.waybar.enable = false;
    programs.waybar.style = ../assets/waybar/style.css;
    programs.waybar.settings = {
      mainBar = {
        height = 30; # Waybar height (to be removed for auto height)
        spacing = 10; # Gaps between modules
        output = (lib.elemAt config.my.hyprland.monitors 0).name;

        modules-left = [
          "hyprland/workspaces"
          "mpris"
        ];

        modules-center = [
          "hyprland/window"
        ];

        modules-right = [
          "tray"
          "pulseaudio"
          "network"
          "clock"
          "custom/wlogout"
        ];

        tray = {
          spacing = 10;
        };

        "hyprland/workspaces" = {
          format = "{name}: {icon}";
          format-icons = {
            active = "";
            default = "";
          };
        };

        "hyprland/window" = {
          # Only show on current monitor.
          separate-outputs = true;
        };

        "custom/wlogout" = {
          format = "⏻  "; # Add padding to right-hand side.
          tooltip = "Logout";
          on-click = "${lib.getExe pkgs.uwsm} app -- ${lib.getExe pkgs.wlogout}";
          interval = 0;
        };

        clock = {
          format = "{:%a, %Y-%m-%d %I:%M %p}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };

        cpu = {
          interval = 5;
          format = "{icon0}{icon1}{icon2}{icon3}{icon4}{icon5}{icon6}{icon7}{icon8}{icon9}{icon10}{icon11}";
          format-icons = [
            "<span color='#69ff94'>▁</span>" # green
            "<span color='#2aa9ff'>▂</span>" # blue
            "<span color='#f8f8f2'>▃</span>" # white
            "<span color='#f8f8f2'>▄</span>" # white
            "<span color='#ffffa5'>▅</span>" # yellow
            "<span color='#ffffa5'>▆</span>" # yellow
            "<span color='#ff9977'>▇</span>" # orange
            "<span color='#dd532e'>█</span>" # red
          ];
        };

        memory = {
          format = "{}% ";
        };

        temperature = {
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = [
            ""
            ""
            ""
          ];
        };

        network = {
          format-ethernet = "󰈀";
          tooltip-format-ethernet = "{ifname}: {ipaddr}/{cidr}";
          format-wifi = "";
          tooltip-format-wifi = "{essid} ({signalStrength}%) - {ifname}: {ipaddr}/{cidr}";
          format-linked = "(No IP) 󱘖";
          format-disconnected = "⚠";
          tooltip-format-disconnected = "Disconnected ⚠";
        };

        mpris = {
          ignored-players = [ "kdeconnect" ];
          format = "{dynamic}";
          format-paused = "{dynamic}";
          interval = 1;
          player-icons = {
            default = "▶";
            firefox = "";
            chromium = "";
          };
          status-icons = {
            playing = "▶";
            paused = "";
          };
        };

        pulseaudio = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon}  {format_source}";
          format-bluetooth-muted = "󰝟 {icon}  {format_source}";
          format-muted = "󰝟 {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            headset = "";
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "${lib.getExe pkgs.uwsm} app -- ${lib.getExe pkgs.pavucontrol}";
        };
      };
    };

    stylix.targets.hyprlock.enable = false;
    programs.hyprlock = {
      enable = true;
      extraConfig = ''
        source = ${inputs.catppuccin-hyprland}/themes/frappe.conf

        $accent = $mauve
        $accentAlpha = $mauveAlpha
        $font = JetBrainsMono Nerd Font

        general {
          hide_cursor = true
        }

        background {
          monitor =
          path = ${../assets/wallpapers/davidcohen-EhSxbBCjr9A-unsplash.jpg}
          blur_passes = 0
          color = $base
        }

        label {
          monitor =
          text = Layout: $LAYOUT
          color = $text
          font_size = 25
          font_family = $font
          position = 30, -30
          halign = left
          valign = top
        }

        label {
          monitor =
          text = $TIME
          color = $text
          font_size = 90
          font_family = $font
          position = -30, 0
          halign = right
          valign = top
        }

        label {
          monitor =
          text = cmd[update:43200000] date +"%A, %d %B %Y"
          color = $text
          font_size = 25
          font_family = $font
          position = -30, -150
          halign = right
          valign = top
        }

        {
          monitor = "";
          text = "$FPRINTPROMPT";
          color = "$text";
          font_size = 14;
          font_family = $font;
          position = "0, -107";
          halign = "center";
          valign = "center";
        }

        image {
          monitor =
          path = ${../assets/edward-howell-dZ3YRMco4XU-unsplash.jpg}
          size = 100
          border_color = $accent
          position = 0, 75
          halign = center
          valign = center
        }

        input-field {
          monitor =
          size = 300, 60
          outline_thickness = 4
          dots_size = 0.2
          dots_spacing = 0.2
          dots_center = true
          outer_color = $accent
          inner_color = $surface0
          font_color = $text
          fade_on_empty = false
          placeholder_text = <span foreground="##$textAlpha"><i>󰌾 Logged in as </i><span foreground="##$accentAlpha">$USER</span></span>
          hide_input = false
          check_color = $accent
          fail_color = $red
          fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i>
          capslock_color = $yellow
          position = 0, -47
          halign = center
          valign = center
        }
      '';
    };

    programs.wlogout.enable = true;

    services.hypridle.enable = true;
    services.hypridle.settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        lock_cmd = "hyprlock";
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "hyprlock";
        }
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };

    programs.rofi = {
      enable = true;
      terminal = lib.getExe pkgs.ghostty;
      theme = lib.mkForce "${inputs.rofi-themes-collection}/themes/rounded-nord-dark.rasi";
    };
  };
}
