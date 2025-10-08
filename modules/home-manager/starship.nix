{
  programs.starship = {
    enable = true;
    settings = {
      format = "$directory$git_branch$character";

      character.success_symbol = "[➜](bold green)";
      character.error_symbol = "[➜](bold red)";

      directory.style = "cyan dimmed";
      directory.truncation_length = 6;
      directory.truncation_symbol = "…/";

      git_branch.symbol = " ";
      git_branch.style = "purple";
      git_branch.format = "[$symbol$branch]($style) ";

      #git_status.style = "bold red";
      #git_status.conflicted = "󰞇 ";
      #git_status.ahead = "⇡${count} ";
      #git_status.behind = "⇣${count} ";
      #git_status.staged = "●${count} ";
      #git_status.changed = "✚${count} ";
      #git_status.untracked = "…${count} ";
      #git_status.deleted = "✖${count} ";
      #git_status.renamed = "➜${count} ";
      #git_status.format = "([$all_status]($style)) ";
      
    };
  };
}
