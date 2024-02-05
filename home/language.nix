{...}: let
  enLocale = "en_US.UTF-8";
  # seLocale = "sv_SE.UTF-8";
  # esLocale = "es_ES.UTF-8";
in {
  base = "${enLocale}";
  ctype = "${enLocale}";
  numeric = "${enLocale}";
  collate = "${enLocale}";
  messages = "${enLocale}";

  time = "${enLocale}";
  monetary = "${enLocale}";
  paper = "${enLocale}";
  name = "${enLocale}";
  address = "${enLocale}";
  telephone = "${enLocale}";
  measurement = "${enLocale}";
}
