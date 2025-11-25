{ pkgs, ... }:
{
programs.tmux = {
  enable = true;

  # Prefix
  prefix = "C-a";

  # Mouse support
  mouse = true;

  # Base index (optional)
  baseIndex = 1;

  # Enable sensible defaults
  sensibleOnTop = true;

  # Plugins
  plugins = with pkgs.tmuxPlugins; [

    sensible
    yank
    logging
    open
    copycat
    sessionist
    resurrect
    continuum

    # Catppuccin theme
    {
      plugin = catppuccin;
      extraConfig = ''
        set -g @catppuccin_flavour "mocha"
        set -g @catppuccin_window_status_style "none"
      '';
    }

    # Super Fingers
    {
      plugin = fingers;
      extraConfig = ''
        set -g @fingers-key f
      '';
    }
  ];

  # Extra tmux configuration
  extraConfig = ''
    # --- Fix plugin overrides for new window ---
    unbind -T prefix c
    bind -T prefix c new-window -c "#{pane_current_path}"

    # --- Window/tab navigation ---
    bind -T prefix n next-window
    bind -T prefix p previous-window

    # Rename window
    bind -T prefix , command-prompt "rename-window %%"

    # Split panes same working dir
    bind -T prefix "/" split-window -h -c "#{pane_current_path}"
    bind -T prefix "\\" split-window -v -c "#{pane_current_path}"

    # Reload config
    bind -T prefix r source-file ~/.tmux.conf \; display-message "Reloaded!"

    # Status bar
    set -g status-interval 1
    set -g status-left-length 60
    set -g status-right-length 120

    # Copy mode: stay in copy mode after copying
    set -g @copycat_search_strategy "default"

    # Pane navigation with vim keys
    bind -T prefix h select-pane -L
    bind -T prefix j select-pane -D
    bind -T prefix k select-pane -U
    bind -T prefix l select-pane -R

    # Resize panes
    bind -T prefix H resize-pane -L 5
    bind -T prefix J resize-pane -D 5
    bind -T prefix K resize-pane -U 5
    bind -T prefix L resize-pane -R 5

    # Persist sessions
    set -g @continuum-restore 'on'
  '';
};
}
