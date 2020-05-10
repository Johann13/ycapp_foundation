import 'dart:ui';

import 'package:ycapp_foundation/model/base_model.dart';
import 'package:ycapp_foundation/model/date_util.dart';
import 'package:ycapp_foundation/model/y_firestore_timestamp.dart';
import 'package:ycapp_foundation/ui/y_colors.dart';

enum AdType {
  BigImage,
  SmallImage,
  Text,
  CountDown,
  Twitch,
  Youtube,
}

//type: normal, twitch, youtube, ad (app relevant ads)
class Ad extends BaseModel {
  String _id;
  String type;
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

  Ad(
    this._id,
    this.type,
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
  );

  Ad.fromMap(Map map)
      : this(
          map['id'],
          map['type'] ?? 'normal',
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
        );

  @override
  String get id => _id;

  bool get hasLink => link != null && link.isNotEmpty;

  bool get hasBigImage => bigImage != null && bigImage.isNotEmpty;

  bool get hasSmallImage => smallImage != null && smallImage.isNotEmpty;

  AdType get visualType {
    if (hasBigImage) {
      return AdType.BigImage;
    } else if (hasSmallImage) {
      return AdType.SmallImage;
    } else if (type == 'twitch' && date != null) {
      return AdType.Twitch;
    } else if (type == 'youtube') {
      return AdType.Youtube;
    } else if (date != null) {
      return AdType.CountDown;
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
