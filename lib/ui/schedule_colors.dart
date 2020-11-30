import 'dart:ui';

import 'package:flutter/painting.dart';

class ScheduleColors {
  ScheduleColors._();

  static List<Color> blue = getScheduleColorPallet(
    HSVColor.fromAHSV(1, 195, 66 / 100, 84 / 100),
    HSVColor.fromAHSV(1, 221, 84 / 100, 61 / 100),
  );

  static List<Color> yellow = getScheduleColorPallet(
    HSVColor.fromAHSV(1, 45, 98 / 100, 99 / 100),
    HSVColor.fromAHSV(1, 22, 97 / 100, 96 / 100),
  );

  static List<Color> green = getScheduleColorPallet(
    HSVColor.fromAHSV(1, 74, 90 / 100, 69 / 100),
    HSVColor.fromAHSV(1, 93, 96 / 100, 46 / 100),
  );

  static List<Color> darkOrange = getScheduleColorPallet(
    HSVColor.fromAHSV(1, 39, 99 / 100, 96 / 100),
    HSVColor.fromAHSV(1, 14, 100 / 100, 89 / 100),
  );

  static List<Color> cyan = getScheduleColorPallet(
    HSVColor.fromAHSV(1, 176, 95 / 100, 83 / 100),
    HSVColor.fromAHSV(1, 170, 98 / 100, 57 / 100),
  );

  static List<Color> pink = getScheduleColorPallet(
    HSVColor.fromAHSV(1, 314, 62 / 100, 88 / 100),
    HSVColor.fromAHSV(1, 332, 85 / 100, 72 / 100),
  );

  static List<Color> lightOrange = getScheduleColorPallet(
    HSVColor.fromAHSV(1, 29, 100 / 100, 92 / 100),
    HSVColor.fromAHSV(1, 11, 99 / 100, 79 / 100),
  );

  static List<Color> getScheduleColorPallet(HSVColor from, HSVColor to) {
    double h = ((to.hue - from.hue) / 12);
    double s = ((to.saturation - from.saturation) / 12);
    double v = ((to.value - from.value) / 12);
    print('diffs, h:$h,s:$s,v:$v');
    print('from, h:${from.hue},s:${from.saturation},v:${from.value}');
    print('to, h:${to.hue},s:${to.saturation},v:${to.value}');
    List<Color> l = [];

    for (int i = 0; i < 12; i++) {
      Color c = HSVColor.fromAHSV(
        1,
        from.hue + (h * i),
        from.saturation + (s * i),
        from.value + (v * i),
      ).toColor();
      l.add(c);
    }

    return l;
  }
}
