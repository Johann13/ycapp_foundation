import 'package:ycapp_foundation/model/base_model.dart';

class Ad extends BaseModel {
  String _id;
  String name;
  List<int> days;
  List<String> images;
  String link;

  Ad(
    this._id,
    this.name,
    this.days,
    this.images,
    this.link,
  );

  Ad.fromMap(Map map)
      : this(
          map['id'],
          map['name'],
          map['days'],
          map['images'],
          map['link'],
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
      };
}
