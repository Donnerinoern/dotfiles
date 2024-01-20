{
  ...
}: let
  browser = "firefox.desktop";
  file_manager = "yazi.desktop";
  media_player = "mpv.desktop";
  text_editor = "nvim.desktop";
in {
  config = {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = [ browser ];
        "x-scheme-handler/http" = [ browser ];
        "x-scheme-handler/https" = [ browser ];
        "x-scheme-handler/about" = [ browser ];
        "x-scheme-handler/unknown" = [ browser ];
        "inode/directory" = [ file_manager ];
        "audio/mp3" = [ media_player ];
        "audio/ogg" = [ media_player ];
        "audio/mpeg" = [ media_player ];
        "audio/aac" = [ media_player ];
        "audio/opus" = [media_player];
        "audio/wav" = [ media_player ];
        "audio/webm" = [ media_player ];
        "audio/3gpp" = [ media_player ];
        "audio/3ggp2" = [ media_player ];
        "video/mp4" = [ media_player ];
        "video/x-msvideo" = [ media_player ];
        "video/mpeg" = [ media_player ];
        "video/ogg" = [ media_player ];
        "video/mp2t" = [ media_player ];
        "video/webm" = [ media_player ];
        "video/3ggp" = [ media_player ];
        "video/3ggp2" = [ media_player ];
        "text/plain" = [ text_editor ];
      };
    };
  };
}
