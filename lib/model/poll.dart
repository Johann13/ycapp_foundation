class Poll {
  String id;
  String name;
  String url;
  DateTime createdAt;

  Poll.fromMap(Map<String, dynamic> map) {
    if (map.containsKey('id')) {
      id = map['id'] as String;
    }
    if (map.containsKey('name')) {
      name = map['name'] as String;
    }
    if (map.containsKey('url')) {
      url = map['url'] as String;
    }
    if (map.containsKey('createdAt')) {
      createdAt = DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int);
    }
  }
}
