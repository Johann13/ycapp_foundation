import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/painting.dart';

class ScheduleColors {
  ScheduleColors._();

  static List<Color> blue = getScheduleColorPallet(
    HSVColor.fromAHSV(1, 195, 66 / 100, 84 / 100),
    HSVColor.fromAHSV(1, 221, 84 / 100, 61 / 100),
  );

  static List<Color> yellow = getScheduleColorPallet(
    HSVColor.fromAHSV(1, 45, 99 / 100, 98 / 100),
    HSVColor.fromAHSV(1, 23, 100 / 100, 96 / 100),
  );

  static List<Color> green = getScheduleColorPallet(
    HSVColor.fromAHSV(1, 74, 92 / 100, 78 / 100),
    HSVColor.fromAHSV(1, 93, 95 / 100, 46 / 100),
  );

  static List<Color> darkOrange = getScheduleColorPallet(
    HSVColor.fromAHSV(1, 30, 98 / 100, 91 / 100),
    HSVColor.fromAHSV(1, 11, 100 / 100, 79 / 100),
  );

  static List<Color> cyan = getScheduleColorPallet(
    HSVColor.fromAHSV(1, 177, 94 / 100, 82 / 100),
    HSVColor.fromAHSV(1, 170, 100 / 100, 57 / 100),
  );

  static List<Color> pink = getScheduleColorPallet(
    HSVColor.fromAHSV(1, 315, 62 / 100, 88 / 100),
    HSVColor.fromAHSV(1, 333, 86 / 100, 72 / 100),
  );

  static List<Color> lightOrange = getScheduleColorPallet(
    HSVColor.fromAHSV(1, 40, 98 / 100, 94 / 100),
    HSVColor.fromAHSV(1, 12, 97 / 100, 90 / 100),
  );

  static List<Color> getScheduleColorPallet(HSVColor from, HSVColor to,
      [int split = 12]) {
    double h = double.parse(((to.hue - from.hue) / split).toStringAsFixed(2));
    double s = double.parse(
        ((to.saturation - from.saturation) / split).toStringAsFixed(2));
    double v =
        double.parse(((to.value - from.value) / split).toStringAsFixed(2));
    List<Color> l = [];

    for (int i = 0; i < split; i++) {
      Color c = HSVColor.fromAHSV(
        1,
        double.parse((from.hue + (h * i)).toStringAsFixed(2)).roundToDouble(),
        math.min(
            double.parse((from.saturation + (s * i)).toStringAsFixed(2)), 1.0),
        math.min(double.parse((from.value + (v * i)).toStringAsFixed(2)), 1.0),
      ).toColor();
      l.add(c);
    }

    return l;
  }
}
