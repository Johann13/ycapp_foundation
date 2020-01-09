import 'package:ycapp_foundation/model/base_model.dart';

class User extends BaseModel {
  String _id;
  String lang;
  String country;
  DateTime dateTime;
  UserData data;

  User.fromMap(Map map) {
    data = UserData.fromMap(map['data']);
    _id = map['id'];
    country = map['country'];
    lang = map['language'];
    dateTime =
        DateTime.fromMillisecondsSinceEpoch((map['date']['_seconds'] * 1000));
  }

  @override
  String get id => _id;

  @override
  Map toJson() {
    return {
      'id': id,
      'data': data,
      'date': {
        'seconds': dateTime.millisecondsSinceEpoch ~/ 1000,
      },
      data: data.toJson(),
    };
  }
}

class UserData extends BaseModel {
  List<String> creator;
  List<String> twitch;
  List<String> youtube;

  UserData.fromMap(Map map) {
    creator = (map['creator'] as List).map((d) => d as String).toList();
    twitch = (map['twitch'] as List).map((d) => d as String).toList();
    youtube = (map['youtube'] as List).map((d) => d as String).toList();
  }

  @override
  String get id => 'userData';

  @override
  Map toJson() {
    return {
      'creator': creator,
      'twitch': twitch,
      'youtube': youtube,
    };
  }
}
