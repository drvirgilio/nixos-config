{ config, pkgs, ... }:

{
  ######## SERVICES ##########
  config.services = {
    acpid = {
      enable = true;
      powerEventCommands = ''
        echo -n mem > /sys/power/state
      '';
      lidEventCommands = ''
        xs=$(ps -C xscreensaver -o user=)
        if test $xs; then su $xs -c "xscreensaver-command -lock"; fi
      '';
    };
    printing.enable = true;
    mpd.enable = true;
    nixosManual.showManual = true;
    transmission.enable = true;
    xserver = {
      enable = true;
      displayManager.slim.enable = true;
      displayManager.sessionCommands = ''
        if ! $(pidof -x "gpg-agent" >/dev/null); then
          eval $(gpg-agent --daemon --enable-ssh-support \
            --write-env-file "~/.gpg-agent-info")
        fi
      '';
      desktopManager.xterm.enable = false;
      windowManager.herbstluftwm.enable = true;
      defaultDepth = 24;
      videoDrivers = ["intel"];
      autorun = true;
      startOpenSSHAgent = false;
      exportConfiguration = true;
      synaptics = {
        enable = true;
#        dev = "/dev/input/by-path/platform-i8042-serio-1-event-mouse";
        dev = "/dev/input/event5";
        accelFactor = "0.05";
        maxSpeed = "10";
        twoFingerScroll = true;
        additionalOptions =
        ''
          Option "HorizTwoFingerScroll"   "1"
          Option "VertTwoFingerScroll"    "1"
          Option "VertScrollDelta"        "-80"
          Option "HorizScrollDelta"       "-70"
          #Option "CircularScrolling"  "on"
          #Option "CircScrollTrigger"  "0"
        '';
      };
    };
  };
}
