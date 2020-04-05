import 'dart:math';

import 'package:timezone/timezone.dart';
import 'package:ycapp_foundation/model/schedule/schedule.dart';

class CombinedSchedule {
  List<CombinedScheduleDay> days = [];

  List toMap() {
    return days.map((d) => d.toMap()).toList();
  }

  CombinedSchedule.fromMap(List list) {
    days = list.map((d) => CombinedScheduleDay.fromMap(d)).toList();
  }

  CombinedSchedule() {
    days.add(CombinedScheduleDay(1));
    days.add(CombinedScheduleDay(2));
    days.add(CombinedScheduleDay(3));
    days.add(CombinedScheduleDay(4));
    days.add(CombinedScheduleDay(5));

    days.add(CombinedScheduleDay(6));
    days.add(CombinedScheduleDay(7));
  }

  void clear() {
    days.clear();
    days.add(CombinedScheduleDay(1));
    days.add(CombinedScheduleDay(2));
    days.add(CombinedScheduleDay(3));
    days.add(CombinedScheduleDay(4));
    days.add(CombinedScheduleDay(5));
    days.add(CombinedScheduleDay(6));
    days.add(CombinedScheduleDay(7));
  }

  void add(List<ScheduleSlot> list) {
    list.sort((a, b) {
      if (a.day == b.day) {
        return a.dayPos - b.dayPos;
      } else {
        return a.day - b.day;
      }
    });

    for (ScheduleSlot slot in list) {
      days[slot.day - 1].add(slot);
    }
  }

  CombinedSchedule.withList(List<ScheduleSlot> list) {
    days.clear();
    list.sort((a, b) {
      if (a.day == b.day) {
        return a.dayPos - b.dayPos;
      } else {
        return a.day - b.day;
      }
    });

    days.add(CombinedScheduleDay(1));
    days.add(CombinedScheduleDay(2));
    days.add(CombinedScheduleDay(3));
    days.add(CombinedScheduleDay(4));
    days.add(CombinedScheduleDay(5));

    days.add(CombinedScheduleDay(6));
    days.add(CombinedScheduleDay(7));

    for (ScheduleSlot slot in list) {
      days[slot.day - 1].add(slot);
    }
  }

  int get longestDay {
    if (days == null) {
      return 0;
    }
    return days.fold(0, (t, e) => t + e.length);
    /*
    int i = 0;
    for (var day in days) {
      if (i < day.length) {
        i = day.length;
      }
    }
    return i;*/
  }

  int get slots {
    int i = 0;
    if (days == null || days.isEmpty) {
      return 0;
    }
    days.map((d) => d.slots.length).toList().forEach((s) => i += s);
    return i;
  }

  DateTime get lastUpdate {
    DateTime dateTime = DateTime.utc(2019, 1, 5, 22, 0, 0, 0);
    if (days == null || days.isEmpty) {
      return dateTime;
    }
    this.days.forEach((s) {
      if (s != null && s.lastUpdate != null) {
        if (dateTime.isBefore(s.lastUpdate)) {
          dateTime = s.lastUpdate;
        }
      }
    });
    return dateTime;
  }

  int get earliestStreamStart {
    if (days == null || days.isEmpty) {
      return 0;
    }
    return days.map((day) => day.earliestStreamStart).reduce(min);
  }

  int get latestStreamStart {
    if (days == null || days.isEmpty) {
      return 0;
    }
    return days.map((day) => day.latestStreamStart).reduce(max);
  }

  int get streamDayLength {
    return (latestStreamStart - earliestStreamStart) + 1;
  }

  List<TZDateTime> get times {
    int min = earliestStreamStart;
    int max = latestStreamStart;
    List<TZDateTime> list = [];
    DateTime now = DateTime.now().toUtc();
    for (int i = min; i <= max; i++) {
      list.add(TZDateTime(getLocation('Europe/London'), now.year, now.month,
          now.day, i, 0, 0, 0));
    }
    return list;
  }
}

class CombinedScheduleDay {
  Map<int, CombinedScheduleSlot> slotMap = {};
  int day;

  Map<String, dynamic> toMap() {
    return slotMap.map((i, v) {
      return MapEntry<String, dynamic>('$i', v.toMap());
    });
  }

  CombinedScheduleDay.fromMap(Map<String, dynamic> map) {
    slotMap = map.map((i, v) {
      return MapEntry<int, CombinedScheduleSlot>(
          int.parse(i), CombinedScheduleSlot.fromMap(v));
    });
  }

  CombinedScheduleDay(this.day);

  void add(ScheduleSlot slot) {
    if (!slotMap.containsKey(slot.hour)) {
      slotMap[slot.hour] = CombinedScheduleSlot(slot.hour);
    }
    slotMap[slot.hour].add(slot);
  }

  List<CombinedScheduleSlot> get slots {
    List<CombinedScheduleSlot> list = slotMap.values.toList();
    return list;
  }

  int get length {
    if (slots == null || slots.isEmpty) {
      return 0;
    }
    return slots.fold(0, (t, e) => t + e.length);
    /*
    int i = 0;
    for (var slot in slots) {
      i += slot.length;
    }
    return i;*/
  }

  DateTime get lastUpdate {
    DateTime dateTime = DateTime.utc(2019, 1, 5, 22, 0, 0, 0);
    if (this.slots == null || slots.isEmpty) {
      return dateTime;
    }
    this.slots.forEach((s) {
      if (s != null && s.lastUpdate != null) {
        if (dateTime.isBefore(s.lastUpdate)) {
          dateTime = s.lastUpdate;
        }
      }
    });
    return dateTime;
  }

  int get earliestStreamStart {
    if (slots == null || slots.isEmpty) {
      return 0;
    }
    return slots.map((slot) => slot.hour).reduce(min);
  }

  int get latestStreamStart {
    if (slots == null || slots.isEmpty) {
      return 0;
    }
    return slots.map((slot) => slot.hour).reduce(max);
  }

  int get streamDayLength {
    return (latestStreamStart - earliestStreamStart) + 1;
  }

  List<DateTime> get times {
    int min = earliestStreamStart;
    int max = latestStreamStart;
    List<DateTime> list = [];
    DateTime now = DateTime.now().toUtc();

    while (now.weekday != day) {
      now = now.add(Duration(days: 1));
    }

    DateTime dstStart = DateTime.utc(now.year, 3, 31);
    DateTime dstEnd = DateTime.utc(now.year, 10, 27);
    bool dst = now.isAfter(dstStart) && now.isBefore(dstEnd);
    for (int i = min; i <= max; i++) {
      DateTime d = DateTime.utc(now.year, now.month, now.day, i, 0, 0, 0);
      list.add(d);
    }
    return list;
  }
}

class CombinedScheduleSlot {
  List<ScheduleSlot> _slots = [];
  int hour;

  Map<String, dynamic> toMap() {
    return {
      'slots': slots.map((s) => s.toMap()).toList(),
      'hour': hour,
    };
  }

  CombinedScheduleSlot.fromMap(Map<String, dynamic> map) {
    _slots = (map['slots'] as List)
        .map((s) => ScheduleSlot.fromMap(s['twitchId'], s))
        .toList();
    hour = map['hour'];
  }

  CombinedScheduleSlot(this.hour);

  List<ScheduleSlot> get slots => _slots;

  /*
          .where((s) =>
      s.title != 'TBA' && s.title != 'TBC' && s.title.isNotEmpty)
*/

  void add(ScheduleSlot slot) {
    if (!slots.contains(slot)) {
      slots.add(slot);
    }
  }

  DateTime get lastUpdate {
    DateTime dateTime = DateTime.utc(2019, 1, 5, 22, 0, 0, 0);
    if (this.slots == null) {
      return dateTime;
    }
    if (this.slots.isEmpty) {
      return dateTime;
    }
    this.slots.forEach((s) {
      if (s != null && s.lastUpdate != null) {
        if (dateTime.isBefore(s.lastUpdate)) {
          dateTime = s.lastUpdate;
        }
      }
    });
    return dateTime;
  }

  int get earliestStreamStart {
    return slots.map((slot) => slot.hour).reduce(min);
  }

  int get latestStreamStart {
    return slots.map((slot) => slot.hour).reduce(max);
  }

  int get streamDayLength {
    return (latestStreamStart - earliestStreamStart) + 1;
  }

  int get length {
    return slots.map((slot) => slot.length).reduce(max);
  }
}
