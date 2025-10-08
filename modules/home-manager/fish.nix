{ config, pkgs, ... }:
{
  programs.fish = {
    enable = true;
    
    shellInit = ''
      set -q PAGER; or set -Ux PAGER less
      set -q EDITOR; or set -Ux EDITOR vim
      
      set fish_greeting
      
      starship init fish | source
    '';

    shellAbbrs = {
      "-"    = "cd -";
      ".."   = "cd ..";
      nv     = "nvim";
      tarls  = "tar -tvf";
      untar  = "tar -xv";
      zz     = "exit";

      l      = "ls -lah";
      ldot   = "ls -ld .*";
      ll     = "ls -l";
      lsa    = "ls -aGF";

      c      = "clear";
      h      = "history";

      # date/time
      ds     = "date +%Y-%m-%d";
      ts     = "date +%Y-%m-%dT%H:%M:%SZ";
      ymd    = "date +%Y%m%d";

      # git abbreviations
      gaa    = "git add -A";
      ga     = "git add";
      gbd    = "git branch --delete";
      gb     = "git branch";
      gc     = "git commit";
      gcm    = "git commit -m";
      gcob   = "git checkout -b";
      gco    = "git checkout";
      gd     = "git diff";
      gl     = "git log";
      glo    = "git log --oneline";
      gp     = "git push";
      gpom   = "git push origin main";
      gs     = "git status";
      gst    = "git stash";
      gstp   =  "git stash pop";

      # nix abbreviations
      ncg    = "nix-collect-garbage";
    };

    shellAliases = {
      "grep"    = "grep --color=auto --exclude-dir={.git,.hg,.svn}";
      "ping"    = "ping -c 5";
    };
    
    functions = {
      allexts = ''
        function allexts --description "Show all extentions in a project"
          find . -not \( -wholename './.git' -prune \) -type f -name '*.*' | sed 's|.*\.|\.|' | sort | uniq -c
        end
      '';

      bak = ''
        function bak --description 'backup a file'
          set --local now (date +"%Y%m%d-%H%M%S")
          for f in $argv
            if not test -e "$f"
              echo "file not found: $f" >&2
              continue
            end
            cp -R "$f" "$f".$now
          end
        end
      '';	

      benchmark = ''
        function benchmark \
          --description 'benchmark a shell' \
          --argument-names shellname

          test -n "$shellname" || set shellname fish
          echo "running $shellname 10 times..."
          for i in (seq 10)
            /usr/bin/time $shellname -i -c exit
          end
        end
      '';
	
      cdpr = ''
        function cdpr --description "cd to the project root"

          if ! git rev-parse --is-inside-work-tree &>/dev/null
            echo "cdpr: Cannot cd to project root. \$PWD not in a git project."
          end
          cd (git rev-parse --show-toplevel)
        end
      '';

      extract = ''
        function extract --description "Expand or extract bundled & compressed files"
          for file in $argv
            if test -f $file
              switch $file
                case "*.tar.bz2"
                    tar xjf $file
                case "*.tar.gz" "*.tgz"
                    tar xzf $file
                case "*.bz2"
                    bunzip2 $file
                case "*.rar"
                    rar x $file
                case "*.gz"
                    gunzip $file
                case "*.tar"
                    tar xf $file
                case "*.tbz2"
                    tar xjf $file
                case "*.tgz"
                    tar xzf $file
                case "*.zip"
                    unzip $file
                case "*.Z"
                    uncompress $file
                case "*.7z"
                    7z x $file
                case '*'
                    echo "$file cannot be extracted via extract"
              end
            else
              echo >&2 "$file is not a valid file"
            end
          end
        end
      '';  		

    };

  };  
}
