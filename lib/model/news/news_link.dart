

class NewsLink {
  String name;
  String _url;
  String _route;

  NewsLink.fromMap(Map map) {
    if (map.containsKey('name')) {
      name = map['name'];
    }
    if (map.containsKey('url')) {
      _url = map['url'];
    }
    if (map.containsKey('route')) {
      _route = map['route'];
    }
  }

  String get url => _url;
  String get route => _route;

  bool get hasUrl => _url != null && _url.isNotEmpty;

  bool get hasRoute => _route != null && _route.isNotEmpty;

  bool get isYoutube {
    if (hasRoute) {
      return _route.contains('youtube');
    }
    if (hasUrl) {
      return _url.contains('youtube');
    }
    return false;
  }

  bool get isTwitch {
    if (hasRoute) {
      return _route.contains('twitch');
    }
    if (hasUrl) {
      return _url.contains('twitch');
    }
    return false;
  }
}
