import 'dart:ui';

import 'package:ycapp_foundation/model/base_model.dart';
import 'package:ycapp_foundation/ui/y_colors.dart';

enum AdType {
  BigImage,
  SmallImage,
  Text,
}

class Ad extends BaseModel {
  String _id;
  String title;
  String subtitle;
  List<int> days;
  DateTime from;
  DateTime to;
  String smallImage;
  String bigImage;
  List<String> creator;
  List<String> twitch;
  List<String> youtube;
  String link;
  Color color;

  Ad(
    this._id,
    this.title,
    this.subtitle,
    this.days,
    this.from,
    this.to,
    this.smallImage,
    this.bigImage,
    this.link,
    this.color,
    this.creator,
    this.twitch,
    this.youtube,
  );

  Ad.fromMap(Map map)
      : this(
          map['id'],
          map['title'],
          map['subtitle'],
          map['days'],
          map['from'],
          map['to'],
          map['smallImage'],
          map['bigImage'],
          map['link'],
          map.containsKey('color')
              ? Color(
                  int.parse(
                    '#' + map['color'],
                    radix: 16,
                  ),
                )
              : YColors.primaryColor,
          map['creator'],
          map['twitch'],
          map['youtube'],
        );

  @override
  String get id => _id;

  bool get hasLink => link != null && link.isNotEmpty;

  bool get hasBigImage => bigImage != null && bigImage.isNotEmpty;

  bool get hasSmallImage => smallImage != null && smallImage.isNotEmpty;

  AdType get type {
    if (hasBigImage) {
      return AdType.BigImage;
    } else if (hasSmallImage) {
      return AdType.SmallImage;
    } else {
      return AdType.Text;
    }
  }

  @override
  Map toJson() => {
        'id': _id,
        'title': title,
        'subtitle': subtitle,
        'days': days,
        'smallImage': smallImage,
        'bigImage': bigImage,
        'link': link,
        'color': color.value.toRadixString(16),
        'creator': creator,
        'twitch': twitch,
        'youtube': youtube,
      };
}
