{
  programs.git = {
    enable = true;
    userName = "astro81";
    userEmail = "caien720@protonmail.com";
    
    aliases = {
      pu = "push";
      co = "checkout";
      cm = "commit";
      aa = "add -A";
      gcm = "!git add -A && git commit -am";
    };
    
    # extraConfig = {
    # credential = {
    #   helper = "store --file ~/.git-credentials";
    #   };
    # };

  };

} 
