#
#  wofi home-manager configuration.
#
#  flake.nix
#   └─ ./hosts
#       └─ ./common
#           └─ ./home
#               ├─ home.nix !
#               └─ ./modules
#                   └─ wofi.nix *
#

{
  programs.wofi = {
    enable = true;
    settings = {
      mode = "drun";
      allow_images = true;
      image_size = 40;
      term = "kitty";
      insensitive = true;
      location = "center";
      no_actions = true;
      prompt = "Search";
      width = "1024";
    };
    style = ''
      @define-color base   #1e1e2e;
      @define-color mantle #181825;
      @define-color crust  #11111b;

      @define-color text     #cdd6f4;
      @define-color subtext0 #a6adc8;
      @define-color subtext1 #bac2de;

      @define-color surface0 #313244;
      @define-color surface1 #45475a;
      @define-color surface2 #585b70;

      @define-color overlay0 #6c7086;
      @define-color overlay1 #7f849c;
      @define-color overlay2 #9399b2;

      @define-color blue      #89b4fa;
      @define-color lavender  #b4befe;
      @define-color sapphire  #74c7ec;
      @define-color sky       #89dceb;
      @define-color teal      #94e2d5;
      @define-color green     #a6e3a1;
      @define-color yellow    #f9e2af;
      @define-color peach     #fab387;
      @define-color maroon    #eba0ac;
      @define-color red       #f38ba8;
      @define-color mauve     #cba6f7;
      @define-color pink      #f5c2e7;
      @define-color flamingo  #f2cdcd;
      @define-color rosewater #f5e0dc;


      * {
        font-family: SFPro;
        font-size: 17px;
        border-radius: 15px;
      }

      window {
        margin: 5px;
        background-color: @crust;
        border: 3px solid @mauve;
        border-radius: 15px;
      }

      #outer-box {
        margin: 4px;
        border-radius: 15px;
      }

      #input {
        margin: 10px 10px 20px 10px;
        background-color: @mantle;
        color: @subtext1;
        border-radius: 8px;
        padding: 5px;
        border: 1px solid @subtext1; 
      }

      #inner-box {
        margin: 0px 10px 50px 10px;
        border-radius: 0px;
        background-color: @crust;
      }

      #scroll {
        margin: 0px 0px;
        border-radius: 8px;
        border: none;
      }

      #text {
        margin: 2px;
      }

      #entry {
        border: none;
        border-radius: 8px;
      }

      #entry:selected {
        color: @crust;
        background-color: @teal;
      }
    '';
  };
}
