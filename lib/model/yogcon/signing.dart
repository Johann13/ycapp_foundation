
import 'package:ycapp_foundation/model/base_model.dart';
import 'package:ycapp_foundation/model/yogcon/yogcon_base_model.dart';


class YCSigning extends BaseModel{
  SigningDay sa;
  SigningDay su;

  YCSigning.fromMap(Map map) {
    sa = SigningDay.fromMap(map['sa']);
    su = SigningDay.fromMap(map['su']);
  }

  YCSigning(List<Signing> list) {
    sa = SigningDay(list.where((s)=>s.day==1).toList());
    su = SigningDay(list.where((s)=>s.day==2).toList());
  }

  @override
  String get id => 'sigings';

  @override
  Map toJson() {
    return {
      'sa':sa.toJson(),
      'su':su.toJson(),
    };
  }

}

class Signing extends YogconBase {
  SigningTable a;
  SigningTable b;

  Signing.fromMap( Map map) : super.fromMap( map) {
    a = SigningTable.fromMap(map['a']);
    b = SigningTable.fromMap(map['b']);
  }

  @override
  Map toJson() {
    return super.toJson()
      ..addAll({
        'a': a.toJson(),
        'b': b.toJson(),
      });
  }
}

class SigningDay extends YogconContainer<Signing> {
  List<Signing> signings;


  SigningDay.fromMap(Map map) {
    signings =
        (map['signings'] as List).map((m) => Signing.fromMap(m)).toList();
  }

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

  @override
  String get id => 'SigningDay_${first.day}';

  @override
  Map toJson() {
    return {
      'signings': signings.map((s) => s.toJson()).toList(),
    };
  }
}

class SigningTable extends BaseModel{
  List<String> creator;
  String title;

  SigningTable.fromMap(Map map) {
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


  @override
  Map toJson() {
    return {
      'title': title,
      'creator': creator,
    };
  }

  @override
  String get id => title;
}
