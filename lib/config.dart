class AppConfig extends Configuration {
  HeroConfig(String path): super.fromFile(File(path));

  DatabaseConfiguration database;
  String jwt_secret;
}
