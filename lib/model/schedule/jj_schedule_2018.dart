import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ycapp_foundation/ui/y_colors.dart';
import 'package:ycapp_foundation/model/y_firestore_timestamp.dart';


class JJScheduleSlot2018 {
  String id;
  int day;
  int slot;
  DateTime start;
  String title;
  List<String> creator;
  Color _color;
  bool darkText;
  String youtubeUrl;
  String twitchUrl;
  String desc;
  int length;
  bool showStart;

  JJScheduleSlot2018.fromMap(Map map) {
    if (map.containsKey('id')) {
      this.id = map['id'];
    }
    if (map.containsKey('day')) {
      this.day = map['day'];
    }
    if (map.containsKey('slot')) {
      this.slot = map['slot'];
    }
    if (map.containsKey('start')) {
      if (map['start'] is int) {
        start = DateTime.fromMillisecondsSinceEpoch(map['start']);
      } else if (map['start'] is Timestamp) {
        Timestamp t = map['start'];
        start = t.toDate();
      } else {
        start = map['start'];
      }
    }
    if (map.containsKey('title')) {
      this.title = map['title'];
    }
    if (map.containsKey('creator')) {
      List l = map['creator'];
      creator = l.cast<String>();
    }

    if (map.containsKey('color')) {
      String c = map['color'];
      _color = Color(int.parse(c, radix: 16));
      darkText = _color.computeLuminance() > 0.5;
    } else {
      _color = YColors.primaryColorAlpha;
      darkText = false;
    }
    if (map.containsKey('youtubeUrl')) {
      youtubeUrl = map['youtubeUrl'];
    }
    if (map.containsKey('twitchUrl')) {
      twitchUrl = map['twitchUrl'];
    }
    if (map.containsKey('desc')) {
      desc = map['desc'];
    }
    length = 1;
    showStart = true;
  }

  String get key {
    return '$id$day$slot';
  }

  bool get hasLinks {
    return hasYoutubeLink || hasTwitchLink;
  }

  bool get hasOneLink {
    return (!hasYoutubeLink && hasTwitchLink) ||
        (hasYoutubeLink && !hasTwitchLink);
  }

  bool get hasYoutubeLink {
    return youtubeUrl != null;
  }

  bool get hasTwitchLink {
    return twitchUrl != null;
  }

  bool get hasDesc {
    return desc != null;
  }

  set color(Color color) {
    _color = color;
    darkText = _color.computeLuminance() > 0.5;
  }

  Color get darkColor {
    Color c = Colors.black54;
    int a = ((color.alpha + c.alpha) / 2).round();
    int r = ((color.red + c.red) / 2).round();
    int g = ((color.green + c.green) / 2).round();
    int b = ((color.blue + c.blue) / 2).round();
    return Color.fromARGB(a, r, g, b);
  }

  Color get color {
    return _color;
  }

  bool get isEnded {
    DateTime now = DateTime.now().toUtc();
    DateTime start = this.start.toUtc();
    DateTime end = start.add(Duration(hours: 3));
    return now.isAfter(end);
  }

  bool get isComing {
    DateTime now = DateTime.now().toUtc();
    DateTime start = this.start.toUtc();
    return now.isBefore(start);
  }

  bool get isStream {
    DateTime now = DateTime.now().toUtc();
    DateTime start = this.start.toUtc();
    DateTime end = start.add(Duration(hours: 3));
    return now.isBefore(end) && now.isAfter(start);
  }

  Color get borderColor {
    if (isStream) {
      return YColors.accentColor;
    } else if (isEnded) {
      return YColors.primaryColorPallet[900];
    }
    return YColors.primaryColor;
  }

  String get state {
    if (isEnded) {
      return ' (Ended)';
    } else if (isComing) {
      return '';
    } else {
      return ' (Running)';
    }
  }

  int operator -(JJScheduleSlot2018 other) {
    return this.start.toUtc().difference(other.start.toUtc()).inHours;
  }
}

class JJScheduleDay2018 {
  int day;
  List<JJScheduleSlot2018> slots;

  JJScheduleDay2018(this.day, this.slots);

  int get lastSlot {
    for (int i = slots.length - 1; i >= 0; i--) {
      if (slots[i].title != 'TBC') {
        return i + 1;
      }
    }
    return 0;
  }

  JJScheduleSlot2018 getSlot(int slot) {
    if (slot >= slots.length) {
      return slots.last;
    }
    return slots[slot];
  }

  JJScheduleSlot2018 operator [](int index) {
    return slots[index];
  }

  void operator []=(int index, JJScheduleSlot2018 slot) {
    this.slots[index] = slot;
  }

  void add(JJScheduleSlot2018 slot) {
    this.slots.add(slot);
  }
}

class JJScheduleWeek2018 {
  int week;
  List<JJScheduleDay2018> days;

  JJScheduleWeek2018(this.week, this.days);

  int get longestDay {
    int i = 0;
    for (JJScheduleDay2018 day in days) {
      if (day.lastSlot > i) {
        i = day.lastSlot;
      }
    }
    return i;
  }

  List<JJScheduleSlot2018> getSlots(int slots) {
    return days.map((day) => day.getSlot(slots)).toList();
  }
}

class JJSchedule2018 {
  List<JJScheduleWeek2018> weeks;
  List<JJScheduleDay2018> days;
  List<JJScheduleSlot2018> slots;

  JJSchedule2018(List<JJScheduleSlot2018> list) {
    generateSchedule(list);
  }

  void generateSchedule(List<JJScheduleSlot2018> list) {
    slots = list;
    days = [];
    for (int i = 0; i < 31; i++) {
      days.add(JJScheduleDay2018(i, []));
    }

    for (int i = 0; i < slots.length; i++) {
      JJScheduleSlot2018 slot = slots[i];
      if (slot.slot == 1) {
        slot.showStart = true;
        days[slot.day - 1].slots.add(slot);
      } else {
        if (slot.day != slots[i - 1].day) {
          slot.showStart = true;
          days[slot.day - 1].slots.add(slot);
        } else if (slot.title == slots[i - 1].title) {
          slots[i - 1].length += 1;
          slot.id = slots[i - 1].id;
          slot.color = slots[i - 1].color;
          slot.desc = slots[i - 1].desc;
          slot.darkText = slots[i - 1].darkText;
          slot.length = slots[i - 1].length;
          slot.twitchUrl = slots[i - 1].twitchUrl;
          slot.youtubeUrl = slots[i - 1].youtubeUrl;
          //slot.showStart = false;
          days[slot.day - 1].slots.add(slot);
        } else {
          slot.showStart = true;
          days[slot.day - 1].slots.add(slot);
        }
      }
    }

    weeks = [];
    weeks.add(JJScheduleWeek2018(0, [days[0], days[1]]));
    weeks.add(JJScheduleWeek2018(1, []));
    weeks.add(JJScheduleWeek2018(2, []));
    weeks.add(JJScheduleWeek2018(3, []));
    weeks.add(JJScheduleWeek2018(4, []));
    weeks.add(JJScheduleWeek2018(5, []));

    for (int i = 0; i < 5; i++) {
      for (int d = 0; d < 7; d++) {
        int index = ((i * 7) + d) + 2;
        if (index < days.length) {
          weeks[i + 1].days.add(days[index]);
        }
      }
    }
  }
}
