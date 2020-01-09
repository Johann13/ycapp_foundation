
import 'package:ycapp_foundation/model/news/news_link.dart';

Map<String, String> filterChoices = {
  'twitch': 'Twitch',
  'youtube': 'Youtube',
  'app': 'App',
  'podcast': 'Podcast',
  'merch': 'Merch',
  'yogcon': 'YogCon',
  'mainchannel': 'MainChannel',
};

class News {
  String id;
  String title;
  String _shortText;
  String image;
  String smallImage;
  String text;
  List<NewsLink> links;
  List<String> _tags;
  DateTime createdAt;

  News.fromMap(Map map) {
    if (map.containsKey('id')) {
      id = map['id'];
    }
    if (map.containsKey('title')) {
      title = map['title'];
    }
    if (map.containsKey('shortText')) {
      _shortText = map['shortText'];
    }
    if (map.containsKey('text')) {
      text = map['text'];
    }
    if (map.containsKey('image')) {
      image = map['image'];
    }
    if (map.containsKey('smallImage')) {
      smallImage = map['smallImage'];
    }
    if (map.containsKey('links')) {
      List list = map['links'];
      links = list.map((l) => NewsLink.fromMap(l)).toList();
    }
    if (map.containsKey('createdAt')) {
      //Timestamp t = map['createdAt'];
      //createdAt = t.toDate();
    }
    if (map.containsKey('tags')) {
      List list = map['tags'];
      _tags = list.cast<String>();
    } else {
      _tags = [];
    }
  }

  List<String> get tags {
    _tags.sort((a, b) => a.compareTo(b));
    return _tags;
  }

  List<String> get tagNames {
    List<String> list = _tags
        .map((tag) => filterChoices[tag.toLowerCase()])
        .where((tag) => tag != null)
        .toList();
    list.sort((a, b) => a.compareTo(b));
    return list;
  }

  String get tagString {
    return tagNames.join(', ');
  }

  bool get hasTags {
    return tagNames.isNotEmpty;
  }

  bool get hasShortText {
    if (_shortText == null) {
      return false;
    }
    return _shortText.isNotEmpty;
  }

  String get shortText {
    if (!hasShortText) {
      return text;
    } else {
      return _shortText;
    }
  }

  bool get hasSmallImage {
    if (smallImage == null) {
      return false;
    }
    return smallImage.isNotEmpty;
  }
}