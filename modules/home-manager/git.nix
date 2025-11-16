{
  programs.git = {
    enable = true;
    
    settings = {
      user.name = "astro81";
      user.email = "caien720@protonmail.com";

      alias = {
        pu = "push";
        co = "checkout";
        cm = "commit";
        aa = "add -A";
        gcm = "!git add -A && git commit -am";
      };
    };
    
    # extraConfig = {
    # credential = {
    #   helper = "store --file ~/.git-credentials";
    #   };
    # };

  };

} 
