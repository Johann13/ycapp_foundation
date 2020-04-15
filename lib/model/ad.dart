import 'dart:ui';

import 'package:ycapp_foundation/model/base_model.dart';

class Ad extends BaseModel {
  String _id;
  String name;
  List<int> days;
  List<String> images;
  List<String> creator;
  List<String> twitch;
  List<String> youtube;
  String link;
  Color color;

  Ad(
    this._id,
    this.name,
    this.days,
    this.images,
    this.link,
    this.color,
    this.creator,
    this.twitch,
    this.youtube,
  );

  Ad.fromMap(Map map)
      : this(
          map['id'],
          map['name'],
          map['days'],
          map['images'],
          map['link'],
          Color(
            int.parse(
              '#' + map['color'],
              radix: 16,
            ),
          ),
          map['creator'],
          map['twitch'],
          map['youtube'],
        );

  @override
  String get id => _id;

  @override
  Map toJson() => {
        'id': _id,
        'name': name,
        'days': days,
        'images': images,
        'link': link,
        'color': color.value.toRadixString(16),
        'creator': creator,
        'twitch': twitch,
        'youtube': youtube,
      };
}
