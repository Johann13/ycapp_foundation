import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ycapp_foundation/model/base_model.dart';
import 'package:ycapp_foundation/model/yogcon/yogcon_base_model.dart';
import 'package:ycapp_foundation/ui/y_colors.dart';

class YCSchedule extends BaseModel {
  YCDay sa;
  YCDay su;

  YCSchedule(List<YCSlot> slots) {
    sa = YCDay(slots.where((s) => s.day == 1).toList());
    su = YCDay(slots.where((s) => s.day == 2).toList());
  }

  List<YCSlot> get slots => [
        ...sa.slots,
        ...su.slots,
      ];

  @override
  String get id => 'ycschedule';

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'sa': sa.toJson(),
      'su': su.toJson(),
    };
  }
}

class YCDay extends YogconContainer<YCSlot> {
  List<YCSlot> slots;
  List<YCSlot> main;
  List<YCSlot> out;
  List<YCSlot> mini;

  YCDay(List<YCSlot> slots) {
    this.slots = slots;
    this.slots.sort((a, b) => a.start.compareTo(b.start));
    main = slots.where((s) => s.stage == 1).toList();
    out = slots.where((s) => s.stage == 2).toList();
    mini = slots.where((s) => s.stage == 3).toList();
  }

  @override
  YCSlot get first => slots.first;

  @override
  YCSlot get last => slots.last;

  @override
  int get length => max(main.length, max(out.length, mini.length));

  @override
  DateTime get start => first.start;

  @override
  DateTime get end => last.end;

  @override
  Duration get duration => end.difference(start);

  @override
  int get height => duration.inMinutes ~/ 15;

  @override
  String get id => 'ycscheduleday${first.day}';

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'slots': slots.map((s) => s.toJson()).toList(),
    };
  }
}

class YCSlot extends YogconBase {
  String title;
  String subTitle;
  List<String> creator;
  int stage;

  YCSlot.fromMap(Map map) : super.fromMap(map) {
    title = map['title'] as String;
    subTitle = map['subTitle'] as String;
    creator = [];
    if (map.containsKey('creator')) {
      if (map['creator'] != null) {
        if (map['creator'] is Map) {
          Map<String, dynamic> cmap = map['creator'] as Map<String, dynamic>;
          cmap.keys.forEach((String k) => creator.add(k));
        } else if (map['creator'] is List) {
          creator = (map['creator'] as List).cast<String>();
        }
      }
    }
    stage = map['stage'] as int;
  }

  bool get isMainStage => stage == 1;

  bool get isOutdoorStage => stage == 2;

  String get twitchId {
    if (isMainStage) {
      return '20786541';
    } else if (isOutdoorStage) {
      return '416016021';
    }
    return null;
  }

  Color get color {
    if (isMainStage) {
      return YColors.twitchPallet;
    } else if (isOutdoorStage) {
      return YColors.accentColor;
    }
    return YColors.primaryColor;
  }

  @override
  String get id => '${day}_${stage}_$s';

  @override
  Map<String, dynamic> toJson() {
    return super.toJson()
      ..addAll(<String, dynamic>{
        'title': title,
        'subTitle': subTitle,
        'creator': creator,
        'stage': stage,
      });
  }
}
