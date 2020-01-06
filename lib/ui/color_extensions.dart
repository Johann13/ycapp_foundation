import 'dart:math' as Math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

extension YColor on Color {
  Color get greyscale {
    return TinyColor(this).greyscale().color;
  }

  Color desaturate(int i) {
    return TinyColor(this).desaturate(i).color;
  }

  Color lighten(int l) {
    return TinyColor(this).lighten(l).color;
  }

  Color darken(int l) {
    return TinyColor(this).darken(l).color;
  }

  Color shade(int l) {
    return TinyColor(this).shade(l).color;
  }

  Color tint(int l) {
    return TinyColor(this).tint(l).color;
  }

  Color get textColor {
    double luminance =
        (0.299 * this.red + 0.587 * this.green + 0.114 * this.blue) / 255;
    if (luminance > 0.5) {
      return Colors.black87;
    } else {
      return Colors.white;
    }
  }

  Color get textColorL {
    List<double> list = [
      this.red.toDouble(),
      this.green.toDouble(),
      this.blue.toDouble(),
    ];

    List<double> list2 = [];

    for (double c in list) {
      double d = c / 255.0;
      if (d <= 0.03928) {
        d = d / 12.92;
      } else {
        d = Math.pow(((c + 0.055) / 1.055), 2.4);
      }
      list2.add(d);
    }

    double l = 0.2126 * list2[0] + 0.7152 * list2[1] + 0.0722 * list[2];

    if (l > 0.179) {
      return Colors.black87;
    } else {
      return Colors.white;
    }
  }

  bool get isLight {
    return TinyColor(this).isLight();
  }

  bool get isDark {
    return TinyColor(this).isDark();
  }

  Color get inverseTextColor {
    double luminance =
        (0.299 * this.red + 0.587 * this.green + 0.114 * this.blue) / 255;
    if (luminance > 0.5) {
      return Colors.white;
    } else {
      return Colors.black87;
    }
  }
}
