
import 'package:ycapp_foundation/model/yogcon/yogcon_base_model.dart';

class Signing extends YogconBase {
  SigningTable a;
  SigningTable b;

  Signing.fromMap(String id, Map map) : super.fromMap(id, map) {
    a = SigningTable.fromMap(id, map['a']);
    b = SigningTable.fromMap(id, map['b']);
  }
}

class SigningDay extends YogconContainer<Signing> {
  List<Signing> signings;

  SigningDay(this.signings) {
    this.signings.sort((a, b) => a.start.compareTo(b.start));
  }

  @override
  Signing get last => signings.last;

  @override
  Signing get first => signings.first;

  @override
  int get length => signings.length;

  @override
  DateTime get start => first.start;

  @override
  DateTime get end => last.end;

  @override
  Duration get duration => end.difference(start);

  @override
  int get height => duration.inMinutes ~/ 15;
}

class SigningTable {
  String id;
  List<String> creator;
  String title;

  SigningTable.fromMap(String id, Map map) {
    this.id = id;
    title = map['title'];
    creator = [];
    if (map.containsKey('creator')) {
      if (map['creator'] != null) {
        if (map['creator'] is Map) {
          Map cmap = map['creator'];
          cmap.forEach((k, v) => creator.add(k));
        } else if (map['creator'] is List) {
          creator = (map['creator'] as List).cast<String>();
        }
      }
    }
  }
}
