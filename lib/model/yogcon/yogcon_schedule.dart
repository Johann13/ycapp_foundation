import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ycapp_foundation/ui/y_colors.dart';
import 'package:ycapp_foundation/model/yogcon/yogcon_base_model.dart';

class YCSchedule {
  YCDay sa;
  YCDay su;

  YCSchedule(List<YCSlot> slots) {
    sa = YCDay(slots.where((s) => s.day == 1).toList());
    su = YCDay(slots.where((s) => s.day == 2).toList());
  }

  List<YCSlot> get slots => [
  ...
  sa.slots,
  ...
  su.slots,
  ];


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
  int get length =>
      max(main.length, max(out.length, mini.length));

  @override
  DateTime get start => first.start;

  @override
  DateTime get end => last.end;

  @override
  Duration get duration => end.difference(start);

  @override
  int get height => duration.inMinutes ~/ 15;

}

class YCSlot extends YogconBase {
  String title;
  String subTitle;
  List<String> creator;
  int stage;

  YCSlot.fromMap(String id, Map map) :super.fromMap(id, map) {
    title = map['title'];
    subTitle = map['subTitle'];
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
    stage = map['stage'];
  }

  bool get isMainStage => stage == 1;

  bool get isOutdoorStage => stage == 2;

  String get twitchId{
    if(isMainStage){
      return '20786541';
    }else if(isOutdoorStage){
      return '416016021';
    }
    return null;
  }

  Color get color {
    if (isMainStage) {
      return YColors.twitchPallet;
    } else if (isOutdoorStage) {
      return YColors.accentColorPallet;
    }
    return YColors.primaryColorPallet;
  }

}
