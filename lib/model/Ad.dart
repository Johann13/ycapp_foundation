import 'package:ycapp_foundation/model/base_model.dart';

class Ad extends BaseModel {
  String _id;
  String name;
  List<int> days;
  List<String> images;

  Ad(this._id, this.name, this.days, this.images);

  Ad.fromMap(Map map)
      : this(
          map['id'],
          map['name'],
          map['days'],
          map['images'],
        );

  @override
  String get id => _id;

  @override
  Map toJson() => {
        'id': _id,
        'name': name,
        'days': days,
        'images': images,
      };
}
