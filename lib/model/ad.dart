import 'dart:ui';

import 'package:ycapp_foundation/model/base_model.dart';
import 'package:ycapp_foundation/model/date_util.dart';

enum AdVisual {
  BigImage,
  SmallImage,
  CountDown,
  Text,
}

enum AdType {
  Regular,
  Twitch,
  Youtube,
  Merch,
  App,
  News,
}

//type: twitch, youtube, app, news, merch, other
class Ad extends BaseModel {
  String _id;
  String _type;
  String title;
  String subtitle;
  List<int> days;
  DateTime date;
  DateTime showFrom;
  DateTime showTo;
  String smallImage;
  String bigImage;
  List<String> creator;
  List<String> twitch;
  List<String> youtube;
  String link;
  Color color;
  bool visible;

  Ad(
    this._id,
    this._type,
    this.title,
    this.subtitle,
    this.days,
    this.date,
    this.showFrom,
    this.showTo,
    this.smallImage,
    this.bigImage,
    this.link,
    this.color,
    this.creator,
    this.twitch,
    this.youtube,
    this.visible,
  );

  Ad.fromMap(Map map)
      : this(
          map['id'],
          map['type'] ?? 'other',
          map['title'],
          map['subtitle'],
          ((map['day']) ?? [] as List).cast<int>(),
          map.containsKey('date') ? getDate(map['date']) : null,
          map.containsKey('showFrom') ? getDate(map['showFrom']) : null,
          map.containsKey('showTo') ? getDate(map['showTo']) : null,
          map['smallImage'],
          map['bigImage'],
          map['link'],
          map.containsKey('color')
              ? Color(
                  int.parse(
                    map['color'],
                    radix: 16,
                  ),
                )
              : null,
          ((map['creator']) ?? [] as List).cast<String>(),
          ((map['twitch']) ?? [] as List).cast<String>(),
          ((map['youtube']) ?? [] as List).cast<String>(),
          map['visible'],
        );

  @override
  String get id => _id;

  bool get hasLink => link != null && link.isNotEmpty;

  bool get hasBigImage => bigImage != null && bigImage.isNotEmpty;

  bool get hasSmallImage => smallImage != null && smallImage.isNotEmpty;

  bool get hasDate => date != null;

  bool get hasShowFrom => showFrom != null;

  bool get hasShowTo => showTo != null;

  AdVisual get visualType {
    if (hasBigImage) {
      return AdVisual.BigImage;
    } else if (hasSmallImage) {
      return AdVisual.SmallImage;
    } else if (hasDate) {
      return AdVisual.CountDown;
    } else {
      return AdVisual.Text;
    }
  }

  AdType get type {
    switch (_type) {
      case 'twitch':
        return AdType.Twitch;
      case 'youtube':
        return AdType.Youtube;
      case 'merch':
        return AdType.Merch;
      case 'app':
        return AdType.App;
      case 'news':
        return AdType.News;
      default:
        return AdType.Regular;
    }
  }

  String get typeString => _type;

  set typeString(String s) => _type = s;

  @override
  Map toJson() => {
        'id': _id,
        'type': _type,
        'title': title,
        'subtitle': subtitle,
        'days': days,
        'date': date,
        'showFrom': showFrom,
        'showTo': showTo,
        'smallImage': smallImage,
        'bigImage': bigImage,
        'link': link,
        'color': color?.value?.toRadixString(16),
        'creator': creator,
        'twitch': twitch,
        'youtube': youtube,
      };
}
