class YogconBase {
  int day;
  String _start;
  String _end;

  YogconBase.fromMap(Map map) {
    _start = map['start'];
    _end = map['end'];
    day = map['day'];
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
}

abstract class YogconContainer<T extends YogconBase> {
  T get last;

  T get first;

  int get length;

  DateTime get start;

  DateTime get end;

  Duration get duration;

  int get height;
}
