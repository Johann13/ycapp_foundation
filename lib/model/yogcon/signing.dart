import 'package:ycapp_foundation/model/base_model.dart';
import 'package:ycapp_foundation/model/yogcon/yogcon_base_model.dart';

class YCSigning extends BaseModel {
  SigningDay sa;
  SigningDay su;

  YCSigning.fromMap(Map<String, dynamic> map) {
    sa = SigningDay.fromMap(
      Map<String, dynamic>.from(map['sa'] as Map),
    );
    su = SigningDay.fromMap(
      Map<String, dynamic>.from(map['su'] as Map),
    );
  }

  YCSigning(List<Signing> list) {
    sa = SigningDay(list.where((s) => s.day == 1).toList());
    su = SigningDay(list.where((s) => s.day == 2).toList());
  }

  @override
  String get id => 'sigings';

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'sa': sa.toJson(),
      'su': su.toJson(),
    };
  }
}

class Signing extends YogconBase {
  SigningTable a;
  SigningTable b;

  Signing.fromMap(Map map) : super.fromMap(map) {
    a = SigningTable.fromMap(
      Map<String, dynamic>.from(map['a'] as Map),
    );
    b = SigningTable.fromMap(
      Map<String, dynamic>.from(map['b'] as Map),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll(<String, dynamic>{
        'a': a.toJson(),
        'b': b.toJson(),
      });
  }
}

class SigningDay extends YogconContainer<Signing> {
  List<Signing> signings;

  SigningDay.fromMap(Map<String, dynamic> map) {
    signings = ((map['signings'] as List)
            .map((dynamic e) => Map<String, dynamic>.from(e as Map))
            .toList())
        .map((m) => Signing.fromMap(m))
        .toList();
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
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'signings': signings.map((s) => s.toJson()).toList(),
    };
  }
}

class SigningTable extends BaseModel {
  List<String> creator;
  String title;

  SigningTable.fromMap(Map map) {
    title = map['title'] as String;
    creator = [];
    if (map.containsKey('creator')) {
      if (map['creator'] != null) {
        if (map['creator'] is Map) {
          Map<String, dynamic> cmap =
              Map<String, dynamic>.from(map['creator'] as Map);
          cmap.keys.forEach((String k) => creator.add(k));
        } else if (map['creator'] is List) {
          creator =
              (map['creator'] as List).map((dynamic e) => e as String).toList();
        }
      }
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'creator': creator,
    };
  }

  @override
  String get id => title;
}
