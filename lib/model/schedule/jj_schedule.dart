import 'dart:math';

import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart';
import 'package:ycapp_foundation/model/date_util.dart';
import 'package:ycapp_foundation/ui/y_colors.dart';

class JJVodLink {
  String _name;
  String url;
  String _defaultName;

  JJVodLink(this._name, this.url);

  JJVodLink.fromMap(Map map, {String defaultName = 'VOD'}) {
    this._defaultName = defaultName;
    if (map.containsKey('name')) {
      _name = map['name'];
    }
    if (map.containsKey('url')) {
      url = map['url'];
    }
  }

  String get name {
    if (_name == null) {
      return _defaultName;
    }
    if (_name.isEmpty) {
      return _defaultName;
    }
    return _name;
  }

  Map<String, dynamic> toMap() => {
        'name': _name,
        'url': url,
      };
}

class JJSlot {
  String id;
  int slot;
  int day;
  TZDateTime start;
  double length;
  String title;
  String subtitle;
  String desc;
  List<Color> _color = [];
  Color _border;
  List<String> creator;
  String twitchUrl;
  String youtubeUrl;
  List<JJVodLink> youtubeVODs = [];
  List<JJVodLink> twitchVODs = [];
  int colorOrientation;

  Map<String, dynamic> toMap() => {
        'id': id,
        'slot': slot,
        'day': day,
        'start': start, //Timestamp.fromDate(start),
        'length': length,
        'title': title ?? '',
        'subtitle': subtitle ?? '',
        'desc': desc ?? '',
        'color': _color.map((c) => c.value.toRadixString(16)).toList(),
        'creator': creator,
        'twitchUrl': twitchUrl,
        'youtubeUrl': youtubeUrl,
        'twitchVODs': twitchVODs.map((v) => v.toMap()).toList(),
        'youtubeVODs': youtubeVODs.map((v) => v.toMap()).toList(),
        'colorOrientation': colorOrientation,
        'border': _border?.value?.toRadixString(16),
      };

  JJSlot.fromMap(Map map) {
    setValues(map);
  }

  void setValues(Map map) {
    if (map.containsKey('id')) {
      this.id = map['id'];
    }
    if (map.containsKey('slot')) {
      this.slot = map['slot'];
    }
    if (map.containsKey('start')) {
      start =
          TZDateTime.from(getDate(map['start']), getLocation('Europe/London'));
      day = start.toUtc().day;
    }
    if (map.containsKey('title')) {
      this.title = map['title'];
    }
    if (map.containsKey('subtitle')) {
      this.subtitle = map['subtitle'];
    }
    if (map.containsKey('desc')) {
      this.desc = map['desc'];
    }
    creator = [];
    if (map.containsKey('creator')) {
      /*
      print('${map['creator']}');
      print('${map['creator'].runtimeType}');*/
      List l = map['creator'];
      creator = l.cast<String>();
    }
    if (map.containsKey('color')) {
      var c = map['color'];
      if (c is String) {
        if (c.isEmpty) {
          _color.add(YColors.primaryColorPallet[700]);
        } else {
          if (c.contains(',')) {
            _color = c.split(',').map((s) {
              if (s.startsWith('#')) {
                s = s.substring(1);
              }
              if (s.length == 6) {
                s = 'ff$s';
              }
              return Color(int.parse(s.toLowerCase(), radix: 16));
            }).toList();
          } else {
            _color.add(Color(int.parse(c.toLowerCase(), radix: 16)));
          }
        }
      } else if (map['color'] is List) {
        List<String> hex = (map['color'] as List).cast<String>();
        if (hex != null) {
          if (hex.isNotEmpty) {
            _color = hex
                .map((c) {
                  if (c.startsWith('#')) {
                    c = c.substring(1);
                  }
                  if (c.length < 8) {
                    c = 'ff$c';
                  }
                  if (c.length == 8) {
                    return Color(int.parse(c, radix: 16));
                  }
                  return null;
                })
                .where((c) => c != null)
                .toList();
          }
        }
      } else {
        _color.add(YColors.primaryColorPallet[700]);
      }
    } else {
      _color.add(YColors.primaryColorPallet[700]);
    }
    if (map.containsKey('border')) {
      String c = map['border'];
      if (c != null) {
        if (c.startsWith('#')) {
          c = c.substring(1);
        }
        if (c.length < 8) {
          c = 'ff$c';
        }
        if (c.length == 8) {
          this._border = Color(int.parse(c, radix: 16));
        }
      }
    }

    if (map.containsKey('colorOrientation')) {
      colorOrientation = map['colorOrientation'] ?? 1;
    }
    if (map.containsKey('youtubeUrl')) {
      youtubeUrl = map['youtubeUrl'] ?? '';
    } else {
      youtubeUrl = '';
    }
    if (map.containsKey('twitchUrl')) {
      twitchUrl = map['twitchUrl'] ?? '';
    } else {
      twitchUrl = '';
    }
    try {
      if (map.containsKey('youtubeVODs')) {
        var l = map['youtubeVODs'];
        youtubeVODs.clear();
        l.forEach((m) {
          JJVodLink vod = JJVodLink.fromMap(m, defaultName: 'Youtube VOD');
          youtubeVODs.add(vod);
        });
      }
      if (map.containsKey('twitchVODs')) {
        List l = map['twitchVODs'];
        twitchVODs.clear();
        l.forEach((m) {
          JJVodLink vod = JJVodLink.fromMap(m, defaultName: 'Twitch VOD');
          twitchVODs.add(vod);
        });
      }
    } catch (e) {
      print('$e');
    }
    if (map.containsKey('desc')) {
      desc = map['desc'];
    }
    if (map.containsKey('length')) {
      var v = map['length'];
      if (v is int) {
        length = v.toDouble();
      } else {
        length = v;
      }
    } else {
      length = 3;
    }
  }

  List<Color> get colors => _color;

  set colors(List<Color> list) => _color = list;

  int get coord => day + ((slot - 1) * 31);

  bool get isLive {
    return !(title.isEmpty ||
        title == 'TBA' ||
        title == 'TBC' ||
        (title ?? '').toLowerCase().contains("canceled") ||
        (subtitle ?? '').toLowerCase().contains("canceled") ||
        (title ?? '').toLowerCase().contains('yogscinema') ||
        (subtitle ?? '').toLowerCase().contains('yogscinema'));
  }

  DateTime get end => start.add(Duration(hours: length.toInt()));

  bool get isStream {
    DateTime now = DateTime.now().toUtc();
    return now.isBefore(end) && now.isAfter(start);
  }

  Color get _b => border != null
      ? border
      : isStream
          ? YColors.accentColorPallet[500]
          : YColors.primaryColorPallet[500];

  Color get borderHighlight => _b.isDark ? _b.lighten(20) : _b.darken(20);

  Color get border => _border != null
      ? _border
      : colors[0].isDark ? colors[0].lighten(10) : colors[0].darken(10);

  set border(Color color) => _border = color;

  Color get textColor {
    if (_color.length == 1) {
      return _color[0].textColor;
      /*
      if (color.computeLuminance() > 0.5) {
        return Colors.black;
      } else {
        return Colors.white;
      }*/
    }
    int i = (_color.map((c) => c.computeLuminance()).reduce((a, b) => a + b) /
            _color.length)
        .floor();
    if (i > 0.5) {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  double get textSize {
    if (length <= 3) {
      return 14.0;
    } else if (length <= 6) {
      return 18.0;
    } else if (length <= 9) {
      return 24.0;
    } else {
      return 24.0;
    }
  }

  Color get inverseTextColor {
    //int i = (_color.length / 2).floor();
    if (mix.computeLuminance() <= 0.5) {
      return Colors.black26;
    } else {
      return Colors.white30;
    }
  }

  bool get isMultiColor {
    return _color.length > 1;
  }

  Color get color {
    if (_color.length > 1) {
      return null;
    }
    return _color[0];
  }

  Color get darkColor {
    Color c = Colors.black54;
    Color color = _color[0];
    int a = ((color.alpha + c.alpha) / 2).round();
    int r = ((color.red + c.red) / 2).round();
    int g = ((color.green + c.green) / 2).round();
    int b = ((color.blue + c.blue) / 2).round();
    return Color.fromARGB(a, r, g, b);
  }

  Color get mix {
    double a = 0, r = 0, g = 0, b = 0;
    _color.forEach((c) {
      a += c.alpha;
      r += c.red;
      g += c.green;
      b += c.blue;
    });
    a /= _color.length;
    r /= _color.length;
    g /= _color.length;
    b /= _color.length;
    return Color.fromARGB(a.round(), r.round(), g.round(), b.round());
  }

  Decoration get decoration {
    if (_color.length == 1) {
      return null;
    }
    List<double> stops = [];

    for (int i = 0; i < _color.length; i++) {
      stops.add(i / _color.length + 0.5 / _color.length);
    }

    AlignmentGeometry begin = Alignment.topLeft;
    AlignmentGeometry end = Alignment.bottomRight;

    if (colorOrientation != null) {
      switch (colorOrientation) {
        case 0:
          begin = Alignment.topLeft;
          end = Alignment.bottomRight;
          break;
        case 1:
          begin = Alignment.topCenter;
          end = Alignment.bottomCenter;
          break;
        case 2:
          begin = Alignment.topRight;
          end = Alignment.bottomLeft;
          break;
        case 3:
          begin = Alignment.centerRight;
          end = Alignment.centerLeft;
          break;
        case 4:
          begin = Alignment.bottomRight;
          end = Alignment.topLeft;
          break;
        case 5:
          begin = Alignment.bottomCenter;
          end = Alignment.topCenter;
          break;
        case 6:
          begin = Alignment.bottomLeft;
          end = Alignment.topRight;
          break;
        case 7:
          begin = Alignment.centerLeft;
          end = Alignment.centerRight;
          break;
      }
    }

    return BoxDecoration(
      gradient:
          LinearGradient(begin: begin, end: end, colors: _color, stops: stops),
    );
  }

  bool get hasLinks {
    return hasYoutubeLink || hasTwitchLink;
  }

  bool get hasOneLink {
    return (!hasYoutubeLink && hasTwitchLink) ||
        (hasYoutubeLink && !hasTwitchLink);
  }

  bool get hasYoutubeLink {
    return (youtubeUrl != null && youtubeUrl.isNotEmpty) ||
        youtubeVODs.isNotEmpty;
  }

  bool get hasTwitchLink {
    return (twitchUrl != null && twitchUrl.isNotEmpty) || twitchVODs.isNotEmpty;
  }

  bool get hasDesc {
    return desc != null && desc.isNotEmpty;
  }

  bool get isEnded {
    DateTime now = DateTime.now().toUtc();
    return now.isAfter(end);
  }

  bool get isComing {
    DateTime now = DateTime.now().toUtc();
    return now.isBefore(start);
  }
}

class JJDay {
  int day;

  List<JJSlot> slots = [];

  DateTime get dateTime {
    return DateTime.utc(2019, DateTime.december, day + 1);
  }

  JJDay(this.day, this.slots);

  void add(JJSlot slot) {
    slots.add(slot);
  }

  JJSlot get firstSlot => slots.first;

  JJSlot get lastSlot => slots.last;

  int get weekdayStart => firstSlot.start.weekday;

  int get weekdayEnd => lastSlot.start.weekday;

  Duration get duration => lastSlot.start.difference(firstSlot.start);

  double get length {
    return slots.map((s) => s.length).reduce((a, b) => a + b);
  }

  List<JJTimes> get times {
    List<JJTimes> list =
        slots.map((s) => JJTimes(s.start.toUtc(), s.end.toUtc())).toList();
    list.sort((a, b) => a.start.compareTo(b.start));
    return list;
  }
}

class JJWeek {
  List<JJDay> days;
  final int week;

  JJWeek(this.week) {
    this.days = [];
  }

  List<JJTimes> get times {
    JJDay day = this.days[0];
    for (JJDay d in days) {
      if (d.slots != null) {
        if (d.slots.length > day.slots.length) {
          day = d;
        }
      }
    }
    return day.times;
  }

  double get slotLength {
    return days.map((d) => d.length).reduce(max);
  }

  int get longestDayByNumOfSlots {
    return days.map((d) => d.slots.length).reduce(max);
  }

  List<JJSlot> get slots {
    List<JJSlot> slots = days.map((d) => d.slots).expand((a) => a).toList();
    slots.sort((a, b) {
      if (a.day == b.day) {
        return a.slot - b.slot;
      }
      return a.day - b.day;
    });
    return slots;
  }

  JJDay get lastDay => days.last;

  JJDay get firstDay => days.first;
}

class JJSchedule {
  List<JJDay> days;
  List<JJWeek> weeks;
  List<JJSlot> slots;

  JJSchedule._();

  factory JJSchedule.withMaxWeekSize(List<JJSlot> slots, int maxWeekSize) {
    slots.sort((a, b) {
      if (a.day == b.day) {
        return a.slot - b.slot;
      }
      return a.day - b.day;
    });
    List<JJDay> days = [];
    for (int i = 0; i < 31; i++) {
      days.add(JJDay(i, []));
    }
    for (JJSlot slot in slots) {
      days[slot.day - 1].slots.add(slot);
    }

    List<JJWeek> weeks = [JJWeek(0)];
    for (JJDay day in days) {
      JJWeek last = weeks.last;
      List<JJDay> d = last.days;
      if (d.length >= maxWeekSize) {
        weeks.add(JJWeek(weeks.length));
      }
      if (weeks.last.days.isEmpty) {
        weeks.last.days.add(day);
      } else if (weeks.last.days.length < 7) {
        weeks.last.days.add(day);
      } else if (weeks.last.days.last.weekdayStart != DateTime.sunday) {
        weeks.last.days.add(day);
      }
    }

    JJSchedule schedule = JJSchedule._();
    schedule.slots = slots;
    schedule.days = days;
    schedule.weeks = weeks;
    return schedule;
  }

  factory JJSchedule(List<JJSlot> slots) {
    slots.sort((a, b) {
      if (a.day == b.day) {
        return a.slot - b.slot;
      }
      return a.day - b.day;
    });
    List<JJDay> days = [];
    for (int i = 0; i < 31; i++) {
      days.add(JJDay(i, []));
    }
    for (JJSlot slot in slots) {
      days[slot.day - 1].slots.add(slot);
    }

    List<JJWeek> weeks = [JJWeek(0)];
    for (JJDay day in days) {
      JJWeek last = weeks.last;
      List<JJDay> d = last.days;
      if (d.length >= 7 &&
          weeks.last.days.last.weekdayStart == DateTime.sunday) {
        weeks.add(JJWeek(weeks.length));
      }
      if (weeks.last.days.isEmpty) {
        weeks.last.days.add(day);
      } else if (weeks.last.days.length < 7) {
        weeks.last.days.add(day);
      } else if (weeks.last.days.last.weekdayStart != DateTime.sunday) {
        weeks.last.days.add(day);
      }
    }

    JJSchedule schedule = JJSchedule._();
    schedule.slots = slots;
    schedule.days = days;
    schedule.weeks = weeks;
    return schedule;
  }

  void setSlots(List<JJSlot> slots, [int maxWeekSize]) {
    slots.sort((a, b) {
      if (a.day == b.day) {
        return a.slot - b.slot;
      }
      return a.day - b.day;
    });
    List<JJDay> days = [];
    for (int i = 0; i < 31; i++) {
      days.add(JJDay(i, []));
    }
    for (JJSlot slot in slots) {
      days[slot.day - 1].slots.add(slot);
    }

    List<JJWeek> weeks = [JJWeek(0)];
    for (JJDay day in days) {
      JJWeek last = weeks.last;
      List<JJDay> d = last.days;
      if (d.length >= 7 &&
          weeks.last.days.last.weekdayStart == DateTime.sunday) {
        weeks.add(JJWeek(weeks.length));
      }
      if (weeks.last.days.isEmpty) {
        weeks.last.days.add(day);
      } else if (weeks.last.days.length < 7) {
        weeks.last.days.add(day);
      } else if (weeks.last.days.last.weekdayStart != DateTime.sunday) {
        weeks.last.days.add(day);
      }
    }

    this.slots = slots;
    this.days = days;
    this.weeks = weeks;
  }

  void setSlotsWithWeekSize(List<JJSlot> slots, int maxWeekSize) {
    try {
      slots.sort((a, b) {
        if (a.day == b.day) {
          return a.slot - b.slot;
        }
        return a.day - b.day;
      });
      List<JJDay> days = [];
      for (int i = 0; i < 31; i++) {
        days.add(JJDay(i, []));
      }
      for (JJSlot slot in slots) {
        days[slot.day - 1].slots.add(slot);
      }

      List<JJWeek> weeks = [JJWeek(0)];
      for (JJDay day in days) {
        JJWeek last = weeks.last;
        List<JJDay> d = last.days;
        if (d.length >= maxWeekSize) {
          weeks.add(JJWeek(weeks.length));
        }
        if (weeks.last.days.isEmpty) {
          weeks.last.days.add(day);
        } else if (weeks.last.days.length < 7) {
          weeks.last.days.add(day);
        } else if (weeks.last.days.last.weekdayStart != DateTime.sunday) {
          weeks.last.days.add(day);
        }
      }

      this.slots = slots;
      this.days = days;
      this.weeks = weeks;
    } catch (e) {
      print('$e');
    }
  }

  JJSlot get nextStream {
    List<JJSlot> slots = this.slots;
    slots.sort((a, b) {
      if (a.day == b.day) {
        return a.slot - b.slot;
      }
      return a.day - b.day;
    });
    for (JJSlot slot in slots) {
      if (DateTime.now().toUtc().isBefore(slot.start.toUtc())) {
        return slot;
      }
    }
    return null;
  }

  int get longestWeekByDays {
    return weeks.map((d) => d.days.length).reduce(max);
  }

  double get longestDayBySlots {
    return days.map((d) => d.length).reduce(max);
  }

  JJWeek get currentWeek {
    DateTime now = DateTime.now();
    JJWeek jjWeek = weeks[0];
    JJSlot first = slots.first;
    JJSlot last = slots.last;
    if (now.isAfter(last.end)) {
      return jjWeek;
    }
    a:
    for (JJWeek w in weeks) {
      if (now.isBefore(w.days.last.slots.last.end)) {
        jjWeek = w;
        break a;
      }
    }
    return jjWeek;
  }
}

class JJTimes {
  final TZDateTime start;
  final TZDateTime end;

  JJTimes(this.start, this.end);

  int get hours => end.difference(start).inHours;
}
