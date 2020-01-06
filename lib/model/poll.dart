class Poll {
  String id;
  String name;
  String url;
  DateTime createdAt;

  Poll.fromMap(Map map) {
    if (map.containsKey('id')) {
      id = map['id'];
    }
    if (map.containsKey('name')) {
      name = map['name'];
    }
    if (map.containsKey('url')) {
      url = map['url'];
    }
    if (map.containsKey('createdAt')) {
      createdAt = DateTime.fromMillisecondsSinceEpoch(map['createdAt']);
    }
  }
}
