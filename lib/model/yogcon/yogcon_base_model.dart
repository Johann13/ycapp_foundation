import 'package:ycapp_foundation/model/base_model.dart';

abstract class YogconBase extends BaseModel {
  int day;
  String _start;
  String _end;

  YogconBase.fromMap(Map<String, dynamic> map) {
    _start = map['start'] as String;
    _end = map['end'] as String;
    day = map['day'] as int;
  }

  String get s => _start;

  String get e => _end;

  DateTime get start {
    List<int> list = _start.split(':').map((i) {
      return int.tryParse(i) ?? 0;
    }).toList();
    DateTime dateTime = DateTime.utc(
      2019,
      8,
      day == 1 ? 3 : 4,
      list[0] - 1,
      list[1],
    );
    return dateTime;
  }

  double get pos {
    DateTime dateTime = start;
    int h = dateTime.hour;
    int m = dateTime.minute;
    return (((h * 60.0) + m) / 15);
  }

  DateTime get end {
    List<int> list = _end.split(':').map((i) {
      return int.parse(i);
    }).toList();
    DateTime dateTime = DateTime.utc(
      2019,
      8,
      day == 1 ? 3 : 4,
      list[0] - 1,
      list[1],
    );
    return dateTime;
  }

  Duration get duration => end.difference(start);

  double get height => duration.inMinutes / 15;

  @override
  String get id => '${day}_$_start';

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'start': _start,
      'end': _end,
      'day': day,
    };
  }
}

abstract class YogconContainer<T extends YogconBase> extends BaseModel {
  T get last;

  T get first;

  int get length;

  DateTime get start;

  DateTime get end;

  Duration get duration;

  int get height;
}
