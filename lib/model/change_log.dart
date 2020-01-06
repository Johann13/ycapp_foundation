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

  Changelog.fromMap(Map map) {
    if (map.containsKey('id')) {
      id = map['id'];
    }
    if (map.containsKey('androidVersion')) {
      androidVersion = map['androidVersion'];
    }
    if (map.containsKey('versionName')) {
      versionName = map['versionName'];
    }
    if (map.containsKey('title')) {
      title = map['title'];
    }
    if (map.containsKey('desc')) {
      desc = map['desc'];
      desc = desc.replaceAll(RegExp('-'), '\n-').replaceAll(RegExp('_'), '\n ');
    }
  }
}
