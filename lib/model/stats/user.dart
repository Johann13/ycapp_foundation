import 'package:ycapp_foundation/model/base_model.dart';

class User extends BaseModel {
  String _id;
  String lang;
  String country;
  DateTime dateTime;
  UserData data;

  User.fromMap(Map<String, dynamic> map) {
    data = UserData.fromMap(map['data'] as Map<String, dynamic>);
    _id = map['id'] as String;
    country = map['country'] as String;
    lang = map['language'] as String;
    dateTime = DateTime.fromMillisecondsSinceEpoch(
        ((map['date']['_seconds'] as int) * 1000));
  }

  @override
  String get id => _id;

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'date': {
        'seconds': dateTime.millisecondsSinceEpoch ~/ 1000,
      },
      'data': data.toJson(),
    };
  }
}

class UserData extends BaseModel {
  List<String> creator;
  List<String> twitch;
  List<String> youtube;

  UserData.fromMap(Map map) {
    creator = (map['creator'] as List<String>).map((d) => d).toList();
    twitch = (map['twitch'] as List<String>).map((d) => d).toList();
    youtube = (map['youtube'] as List<String>).map((d) => d).toList();
  }

  @override
  String get id => 'userData';

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'creator': creator,
      'twitch': twitch,
      'youtube': youtube,
    };
  }
}
