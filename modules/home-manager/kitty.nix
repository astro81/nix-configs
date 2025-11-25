{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    themeFile = "tokyo_night_night";

    font.size = 12;
    font.name = "FiraCode Nerd Font Mono";

    settings = {
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";

      window_padding_width = 12;

      background_opacity = 1;

      cursor_shape = "beam";
      cursor_shape_unfocused = "hollow";
      cursor_beam_thickness = 1.5;

      cursor_trail = 300;
      cursor_trail_decay = "0.2 0.4";

      scrollback_lines = 10000;
      
      scrollbar = "scrolled-and-hovered";
      scrollbar_interactive = true;
      scrollbar_jump_on_click = true;

      scrollbar_width = 0.5;
      scrollbar_hover_width = 0.6;
      scrollbar_gap = 0.4;

      mouse_hide_wait = -1;

      enable_audio_bell = false;


    };

    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      "ctrl+v" = "paste_from_clipboard";

      "ctrl+up" = "scroll_line_up";
      "ctrl+down" = "scroll_line_down";
      
      "ctrl+page_up" = "scroll_page_up";
      "ctrl+page_down" = "scroll_page_down";
      "ctrl+home" = "scroll_home";
      "crtl+end" = "scroll_end";

      "ctrl+shift+z" = "scroll_to_prompt -1";


    };

    extraConfig = "
      modify_font underline_position 2
    ";
  };	

}
