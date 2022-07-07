self: super: {
  material-icons = let version = "4.0.0"; in
    super.fetchFromGitHub {
      name = "material-icons-${version}";

      owner = "google";
      repo = "material-design-icons";
      rev = version;

      postFetch = ''
        mkdir -p $out/share/fonts/opentype $out/share/fonts/truetype
        mv $out/font/*.ttf $out/share/fonts/truetype
        mv $out/font/*.otf $out/share/fonts/opentype
	rm -rf $out/{android,font,ios,png,src,symbols,update,variablefont,.gitignore,LICENSE,README.md}
      '';
      sha256 = "sha256-CoTuUcmEdoOiSq7IxJ5jKJbFRWrruUpR2nJuZBta5RU=";

      meta = with super.lib; {
        description = "System status icons by Google, featuring material design";
        homepage = "https://material.io/icons";
        license = licenses.asl20;
        platforms = platforms.all;
        maintainers = with maintainers; [ mpcsh ];
      };
    };
}
