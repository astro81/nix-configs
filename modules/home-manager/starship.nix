{
  programs.starship = {
    enable = true;

    settings = {
      format = "$directory$git_branch$git_status$character";
      right_format = "$cmd_duration$jobs$nix_shell";

      # Command duration
      cmd_duration.format = "[⏱ $duration]($style) ";
      cmd_duration.style = "yellow";
      cmd_duration.min_time = 500;

      # Background jobs indicator
      jobs.format = "[⚙ $number]($style) ";
      jobs.style = "bold blue";

      # Nix shell indicator
      nix_shell.format = "[ nix-shell]($style)";
      nix_shell.style = "bold green";

      # Prompt character
      character.success_symbol = "[➜](bold green)";
      character.error_symbol   = "[➜](bold red)";

      # Directory
      directory.format = "[$path]($style) ";
      directory.style = "cyan dimmed";
      directory.truncation_length = 6;
      directory.truncation_symbol = "…/";

      # Git branch
      git_branch.symbol = " ";
      git_branch.style  = "purple";
      git_branch.format = "[$symbol$branch]($style) ";

      # Git status
      git_status.style      = "bold red";
      git_status.conflicted = "󰞇 ";
      git_status.ahead      = "⇡\${count} ";
      git_status.behind     = "⇣\${count} ";
      git_status.staged     = "●\${count} ";
      git_status.modified   = "✚\${count} ";
      git_status.untracked  = "…\${count} ";
      git_status.deleted    = "✖\${count} ";
      git_status.renamed    = "➜\${count} ";
      git_status.format     = "([$all_status]($style)) ";
    };
  };
}

