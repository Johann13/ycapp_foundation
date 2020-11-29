class Changelog {
  int id;
  int androidVersion;
  String title;
  String versionName;
  String desc;

  Changelog({
    this.id,
    this.androidVersion,
    this.title,
    this.versionName,
    this.desc,
  });

  Changelog.fromMap(Map<String,dynamic>map) {
    if (map.containsKey('id')) {
      id = map['id'] as int;
    }
    if (map.containsKey('androidVersion')) {
      androidVersion = map['androidVersion'] as int;
    }
    if (map.containsKey('versionName')) {
      versionName = map['versionName'] as String;
    }
    if (map.containsKey('title')) {
      title = map['title'] as String;
    }
    if (map.containsKey('desc')) {
      desc = map['desc'] as String;
      desc = desc.replaceAll(RegExp('-'), '\n-').replaceAll(RegExp('_'), '\n ');
    }
  }
}
