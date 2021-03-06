import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart';
import 'package:ycapp_foundation/model/channel/channel_lib.dart';
import 'package:ycapp_foundation/model/date_util.dart';
import 'package:ycapp_foundation/ui/y_colors.dart';

import 'jj_schedule.dart';

class SlotTime {
  int hour;
  int min;

  SlotTime(this.hour, this.min);

  @override
  bool operator ==(dynamic other) {
    if (other is! SlotTime) {
      return false;
    } else {
      return other.hour == hour && other.min == min;
    }
  }

  int get value => (hour * 60) + min;

  TZDateTime get toUTC {
    DateTime now = DateTime.now();
    TZDateTime tz = TZDateTime.utc(now.year, now.month, now.day, hour, min);
    return tz;
  }

  TZDateTime get toUK {
    DateTime now = DateTime.now();
    final london = UTC;
    TZDateTime tz = TZDateTime(london, now.year, now.month, now.day, hour, min);
    return tz;
  }

  @override
  int get hashCode => value;
}

class ScheduleSlot {
  int day;
  int slot;
  String title;
  String subTitle;
  List<String> creator;
  List<Color> _color = [];
  int length;
  int lengthMin;
  int height;
  int hour;
  int min;
  DateTime lastUpdate;
  String twitchId;
  ScheduleImage scheduleImage;
  bool _showTitle;
  String notificationTitle;
  String game;
  Color _border;
  FeaturedStream featuredStream;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'day': day,
      'slot': slot,
      'title': title,
      'subTitle': subTitle,
      'creator': creator,
      'color': _color.length == 1
          ? _color[0].value.toRadixString(16)
          : _color.map((c) => c.value.toRadixString(16)).toList(),
      'length': length,
      'hour': hour,
      'min': min,
      'lastUpdate': lastUpdate,
      'twitchId': twitchId,
      'scheduleImage': scheduleImage?.toMap(),
      'shotTitle': _showTitle,
      'notificationTitle': notificationTitle,
      'game': game,
      'border': _border?.value?.toRadixString(16),
      'featuredStream': featuredStream?.toMap(),
      'lengthMin': lengthMin,
      'height': height,
    };
  }

  ScheduleSlot.debug({
    this.title = 'Title',
    this.subTitle = 'Subtitle',
    this.hour = 11,
    this.min = 0,
    this.length = 3,
    this.day = 1,
    this.slot = 1,
    this.lengthMin = 180,
    this.height = 180,
    Color color,
  }) {
    this._color = [color ?? const Color(0xff2752ae)];
  }

  ScheduleSlot.fromMap(String twitchId, Map<String, dynamic> map) {
    try {
      if (map.containsKey('twitchId')) {
        dynamic twitchId = map['twitchId'];
        if (twitchId is int) {
          this.twitchId = '$twitchId';
        } else {
          this.twitchId = map['twitchId'] as String;
        }
      } else {
        this.twitchId = twitchId;
      }
      if (map.containsKey('title')) {
        title = map['title'] as String;
      }
      if (map.containsKey('notificationTitle')) {
        notificationTitle = map['notificationTitle'] as String;
      } else {
        notificationTitle = '';
      }
      if (map.containsKey('game')) {
        game = map['game'] as String;
      } else {
        game = '';
      }
      if (map.containsKey('subTitle')) {
        subTitle = map['subTitle'] as String;
      }
    } catch (e) {
      print('base error: $e');
    }

    try {
      if (map.containsKey('creator')) {
        List<String> l =
        (map['creator'] as List).map((dynamic e) => e as String).toList();
        creator = l;
      }
    } catch (e) {
      print('creator error: $e');
    }

    try {
      if (map.containsKey('color')) {
        dynamic c = map['color'];
        if (c is String) {
          if (c.isEmpty) {
            _color.add(YColors.primaryColor[700]);
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
        } else {
          if (c is List<String>) {
            _color = c.map((String v) {
              return Color(int.parse(v.toLowerCase(), radix: 16));
            }).toList();
          } else {
            _color = (c as List<dynamic>).map((dynamic v) {
              if (v is int) {
                return Color(v);
              } else if (v is String) {
                return Color(int.parse(v.toLowerCase(), radix: 16));
              } else {
                return YColors.primaryColor[700];
              }
            }).toList();
          }
        }
      } else {
        _color.add(YColors.primaryColor[700]);
      }
    } catch (e) {
      print('color error: $e');
    }

    try {
      if (map.containsKey('border')) {
        String c = map['border'] as String;
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
    } catch (e) {
      print('border error: $e');
    }

    try {
      if (map.containsKey('day')) {
        day = map['day'] as int;
      }
      if (map.containsKey('slot')) {
        slot = map['slot'] as int;
      }
      if (map.containsKey('length')) {
        length = map['length'] as int;
      }
      if (map.containsKey('lengthMin')) {
        dynamic lengthMin = map['lengthMin'] as int;
        if (lengthMin is double) {
          this.lengthMin = lengthMin.toInt();
        } else if (lengthMin is int) {
          this.lengthMin = lengthMin;
        }
      } else {
        lengthMin = length * 60;
      }
      if (map.containsKey('height')) {
        height = map['height'] as int;
      } else {
        height = lengthMin;
      }
      if (map.containsKey('hour')) {
        hour = map['hour'] as int;
      }
      if (map.containsKey('min')) {
        min = map['min'] as int;
      }
      if (map.containsKey('lastUpdate')) {
        lastUpdate = getDate(map['lastUpdate']);
      }
    } catch (e) {
      print('base2 error: $e');
    }

    try {
      if (map.containsKey('image') &&
          map.containsKey('imageAuthor') &&
          map.containsKey('imageAuthorLink')) {
        scheduleImage = ScheduleImage(
          map['image'] as String,
          map['imageAuthorLink'] as String,
          map['imageAuthor'] as String,
        );
      }
    } catch (e) {
      print('schedule image error $e');
    }

    if (map.containsKey('showTitle')) {
      _showTitle = map['showTitle'] as bool;
    }

    try {
      if (map.containsKey('featuredStream') && map['featuredStream'] != null) {
        featuredStream = FeaturedStream.fromMap(
          Map<String, dynamic>.from(map['featuredStream'] as Map),
        );
      }
    } catch (e) {
      print('featuredStream error: $e');
    }
  }

  Location get london => getLocation('Europe/London');

  TZDateTime get now => TZDateTime.now(london);

  bool get isFeatured => featuredStream != null;

  double get textSize {
    if (height <= 60) {
      return 8.0;
    } else if (height <= 90) {
      return 8.0;
    } else if (height <= 120) {
      return 9.0;
    } else if (height <= 150) {
      return 9.0;
    } else if (height <= 180) {
      return 10.0;
    } else if (height <= 240) {
      return 11.0;
    } else if (height <= 300) {
      return 11.0;
    } else if (height <= 360) {
      return 12.0;
    } else if (height <= 420) {
      return 12.0;
    } else if (height <= 480) {
      return 14.0;
    } else if (height <= 540) {
      return 14.0;
    } else if (height <= 600) {
      return 16.0;
    } else if (height <= 660) {
      return 16.0;
    } else {
      return 18.0;
    }
    /*
    if (length <= 3) {
      return 12.0;
    } else if (length <= 6) {
      return 14.0;
    } else if (length <= 9) {
      return 18.0;
    } else {
      return 22.0;
    }*/
  }

  bool get isLive {
    return !(title.isEmpty ||
        title == 'TBA' ||
        title == 'TBC' ||
        (title ?? '').toLowerCase().contains("canceled") ||
        (subTitle ?? '').toLowerCase().contains("canceled") ||
        (title ?? '').toLowerCase().contains('yogscinema') ||
        (subTitle ?? '').toLowerCase().contains('yogscinema'));
  }

  bool get isCinema {
    if (!isStream) {
      return false;
    }
    return (title ?? '').toLowerCase().contains('yogscinema') ||
        (subTitle ?? '').toLowerCase().contains('yogscinema');
  }

  int get dayPos {
    return (hour * 60) + min;
  }

  Color get avgColor {
    if(_color.length==1){
      return _color.first;
    }
    return _color.reduce((a, b) {
      HSVColor x = HSVColor.fromColor(a);
      HSVColor y = HSVColor.fromColor(b);
      return HSVColor.fromAHSV(
        (x.alpha + y.alpha) / 2,
        (x.hue + y.hue) / 2,
        (x.saturation + y.saturation) / 2,
        (x.value + y.value) / 2,
      ).toColor();
    });
  }

  Color get textColor {
    if (_color.length == 1) {
      double luminance =
          (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;

      if (luminance > 0.5) {
        return Colors.black;
      } else {
        return Colors.white;
      }
    }
    return avgColor.textColor;
  }

  Color get inverseTextColor {
    //int i = (_color.length / 2).floor();
    if (avgColor.computeLuminance() <= 0.5) {
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
      return avgColor;
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
    double a = 0,
        r = 0,
        g = 0,
        b = 0;
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

  List<Color> get colors => _color;

  set colors(List<Color> list) => _color = list;

  Color get _b =>
      border != null
          ? border
          : isStream
          ? YColors.accentColor[500]
          : YColors.primaryColor[500];

  Color get borderHighlight => _b.isDark ? _b.lighten(20) : _b.darken(20);

  Color get border =>
      _border != null
          ? _border
          : colors[0].isDark
          ? colors[0].lighten(10)
          : colors[0].darken(10);

  set border(Color color) => _border = color;

  /*
  Decoration get decoration {
    if (_color.length == 1) {
      return null;
    }
    List<double> stops = [];

    for (int i = 0; i < _color.length; i++) {
      stops.add(i / _color.length + 0.5 / _color.length);
    }

    return BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _color,
          stops: stops),
    );
  }*/

  String get id {
    return '${day}_$slot';
  }

  String get notificationStringId {
    return '${twitchId}_${day}_${slot}_${nextStream.millisecondsSinceEpoch}';
  }

  int get notificationId {
    return day * 2 + slot + 3;
  }

  TZDateTime get end {
    return start.add(Duration(minutes: lengthMin)).toUtc();
  }

  bool get isStream {
    return now.isBefore(end) && now.isAfter(nextStream);
  }

  bool get ended {
    return now.isAfter(end);
  }

  TZDateTime get nextStream {
    TZDateTime tz = TZDateTime(london, now.year, now.month, now.day, hour, min);
    return tz.add(Duration(days: ((day - tz.weekday) % 7)));
    //dateTime = dateTime.add(Duration(days: ((day - dateTime.weekday) % 7)));
    //return DateTime.utc(dateTime.year, dateTime.month, dateTime.day, hour, min, 0, 0, 0);
  }

  TZDateTime get nextStream2 {
    TZDateTime next = nextStream;
    if (now.day == next.day && !now.isBefore(nextStream)) {
      return next.add(Duration(days: 7));
    }
    return next;
  }

  TZDateTime get start {
    return TZDateTime(london, now.year, now.month, now.day, hour, min);
  }

  bool get hasImage {
    if (scheduleImage != null) {
      if (scheduleImage.url != null) {
        if (scheduleImage.url.isNotEmpty) {
          return true;
        }
      }
    }
    return false;
  }

  bool get showTitle {
    return _showTitle ?? !hasImage;
  }

  bool get isMainChannel => twitchId == '20786541';

  @override
  bool operator ==(dynamic other) {
    if (other is ScheduleSlot) {
      return other.title == title &&
          other.twitchId == twitchId &&
          other.id == id;
    }
    return false;
  }

  SlotTime get slotTime => SlotTime(hour, min);

  @override
  int get hashCode => super.hashCode;
}

class ScheduleDay {
  int day;
  List<ScheduleSlot> slots = [];

  ScheduleDay(this.day);

  void add(ScheduleSlot slot) {
    slots.add(slot);
  }

  double get length {
    double i = 0;
    for (var slot in slots) {
      i += slot.length;
    }
    return i;
  }

  DateTime get lastUpdate {
    DateTime dateTime = DateTime.utc(
        2019,
        1,
        5,
        22,
        0,
        0,
        0);
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

  List<SlotTime> get slotTimes =>
      slots.map((s) => s.slotTime).where((s) => s.min == 0).toList();

  TZDateTime get weekDay {
    TZDateTime now = TZDateTime.now(getLocation('Europe/London'));
    TZDateTime tz =
    TZDateTime(getLocation('Europe/London'), now.year, now.month, now.day);
    return tz.add(Duration(days: (((day + 1) - tz.weekday) % 7)));
  }
/*
  List<DateTime> get times11 => slotTimes
      .map((time) => DateTime.utc(2019, 1, 1, time.hour, time.min, 0, 0, 0))
      .toList();

  List<JJTimes> get times {
    List<JJTimes> list = slots.map((s) => JJTimes(s.start, s.end)).toList();
    list.sort((a, b) => a.start.compareTo(b.start));
    return list;
  }
  */
}

class Schedule {
  String twitchId;
  List<ScheduleDay> days = [];
  List<ScheduleSlot> slots = [];

  Schedule(this.twitchId, List<ScheduleSlot> list) {
    list.sort((a, b) {
      if (a.day == b.day) {
        return a.dayPos - b.dayPos;
      } else {
        return a.day - b.day;
      }
    });
    this.slots = list;

    days.add(ScheduleDay(0));
    days.add(ScheduleDay(1));
    days.add(ScheduleDay(2));
    days.add(ScheduleDay(3));
    days.add(ScheduleDay(4));

    days.add(ScheduleDay(5));
    days.add(ScheduleDay(6));

    for (ScheduleSlot slot in list) {
      days[slot.day - 1].add(slot);
    }
  }

  double get longestDay {
    double i = 0;
    for (var day in days) {
      if (i < day.length) {
        i = day.length;
      }
    }
    return i;
  }

  DateTime get lastUpdate {
    DateTime dateTime = DateTime.utc(
        2019,
        1,
        5,
        22,
        0,
        0,
        0);
    if (this.days.isEmpty) {
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

  List<SlotTime> get slotTimes {
    List<SlotTime> s =
    days.map((day) => day.slotTimes).expand((s) => s).toSet().toList();
    s.sort((a, b) => a.hashCode - b.hashCode);
    return s;
  }

  List<JJTimes> get times {
    List<ScheduleSlot> s = slots;
    s
      ..sort((a, b) {
        return a.slotTime.value - b.slotTime.value;
      });
    DateTime first = s.first.slotTime.toUK;
    DateTime last =
    s.last.slotTime.toUK.add(Duration(minutes: s.last.lengthMin));
    Duration duration = last.difference(first);
    int hm = duration.inMinutes;
    int timeCount = hm ~/ 180;
    //int hours = hm ~/ 60;
    //int mins = hm % 60;
    Location london = getLocation('Europe/London');
    DateTime now = TZDateTime.now(UTC);
    return [
      for (int i = 0; i < timeCount; i++)
        JJTimes(
          TZDateTime(london, now.year, now.month, now.day, 11, 0)
              .add(Duration(hours: (i * 3)))
              .toUtc()
              .add(DateTime
              .now()
              .timeZoneOffset),
          TZDateTime(london, now.year, now.month, now.day, 11, 0)
              .add(Duration(hours: ((i + 1) * 3)))
              .toUtc()
              .add(DateTime
              .now()
              .timeZoneOffset),
        ),
    ].toList();
    /*
    ScheduleDay day = this.days[0];
    for (ScheduleDay d in days) {
      if (d.slots != null) {
        if (d.slots.length > day.slots.length) {
          day = d;
        }
      }
    }
    return day.times;
    */
  }

  List<ScheduleSlot> get slotList {
    return days.map((d) => d.slots).expand((l) => l).toList();
  }

  double get slotLength {
    return days.map((d) => d.length).reduce(max);
  }

  int get longestDayByNumOfSlots {
    return days.map((d) => d.slots.length).reduce(max);
  }

  ScheduleSlot get currentSlot =>
      slots.firstWhere((s) {
        return s.isStream;
      }, orElse: () {
        return null;
      });

  ScheduleSlot get next {
    return slots.reduce((a, b) {
      if (a.nextStream2.isBefore(b.nextStream2)) {
        return a;
      }
      return b;
    });
  }

  List<String> get creator {
    return slots
        .where((slot) => slot.creator != null && slot.creator.isNotEmpty)
        .map((slot) => slot.creator)
        .expand((l) => l)
        .toSet()
        .toList();
  }

/*List<DateTime> get scheduleTimes {
    ScheduleDay d = days[0];
    d.slots.map((s) => s.slotTime).toList();
  }*/
}

class ScheduleImage {
  String url;
  String authorLink;
  String authorName;

  ScheduleImage(this.url, this.authorLink, this.authorName);

  bool get isTwitter {
    return authorLink.contains('twitter');
  }

  Map toMap() {
    return <String, dynamic>{
      'url': url,
      'authorLink': authorLink,
      'authorName': authorName
    };
  }
}

class FeaturedStream {
  String twitchId;
  String name;
  String url;

  FeaturedStream.fromChannel(TwitchChannel channel) {
    this.twitchId = channel.id;
    this.name = channel.twitchData.displayName;
    this.url = channel.url;
  }

  FeaturedStream.fromMap(Map<String, dynamic> map) {
    if (map.containsKey('twitchId')) {
      twitchId = map['twitchId'] as String;
    }
    if (map.containsKey('name')) {
      name = map['name'] as String;
    }
    if (map.containsKey('url')) {
      url = map['url'] as String;
    }
  }

  Map toMap() {
    return <String, dynamic>{
      'twitchId': twitchId,
      'name': name,
      'url': url,
    };
  }

  String get capitilizedName {
    String n = name[0];
    String r = name.substring(1);
    return n.toUpperCase() + r;
  }

  @override
  int get hashCode => twitchId.hashCode;

  @override
  bool operator ==(dynamic other) {
    if (other is FeaturedStream) {
      return other.twitchId == this.twitchId &&
          other.name == this.name &&
          other.url == this.url;
    }
    return false;
  }
}
