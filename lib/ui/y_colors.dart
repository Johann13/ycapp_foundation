import 'dart:math' as Math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart' as t;

class YColors {
  static const Color twitchPurple = const Color(0xff9146FF);
  static const Color twitchAccentPurple = const Color(0xFFbd90ff);
  static const Color twitchPurpleAlphaDark = const Color(0xcc9146FF);
  static const Color twitchPurpleAlpha = const Color(0x999146FF);
  static const Color twitchPurpleAlphaLight = const Color(0x309146FF);
  static const MaterialColor twitchPallet = const MaterialColor(
    0xff9146FF,
    const <int, Color>{
      50: const Color(0xFFc8a2ff),
      100: const Color(0xFFbd90ff),
      200: const Color(0xFFb27dff),
      300: const Color(0xFFa76aff),
      400: const Color(0xFF9c58ff),
      500: const Color(0xff9146FF),
      600: const Color(0xff9146FF),
      700: const Color(0xff7438cc),
      800: const Color(0xFF6531b2),
      900: const Color(0xFF572a99),
      /*
      50: const Color(0xFFb1a0d1),
      100: const Color(0xFFa28dc8),
      200: const Color(0xFF927abf),
      300: const Color(0xFF8366b6),
      400: const Color(0xFF7354ad),
      500: const Color(0xff6441A4),
      600: const Color(0xff5a3a93),
      700: const Color(0xff503483),
      800: const Color(0xFF462d72),
      900: const Color(0xFF3c2762),*/
    },
  );
  static const Color youtubeRed = const Color(0xffff0000);
  static const Color youtubeRedAlphaDark = const Color(0xccff0000);
  static const Color youtubeRedAlpha = const Color(0x99ff0000);
  static const Color youtubeRedAlphaLight = const Color(0x30ff0000);
  static const Color youtubeBlack = const Color(0xff282828);

  static const Color accentColor =  const Color(0xffff8b23);
  static const Color accentColorAlphaDark = const Color(0xccff8b23);
  static const Color accentColorAlpha = const Color(0x99ff8b23);
  static const Color accentColorAlphaLight = const Color(0x30ff8b23);

  static const Color primaryColor = const Color(0xff0094ff);
  static const Color primaryColorAlphaDark = const Color(0xcc0094ff);
  static const Color primaryColorAlpha = const Color(0x990094ff);
  static const Color primaryColorAlphaLight = const Color(0x300094ff);

  static const Color jingleJamLight = const Color(0xffe22659);
  static const Color jingleJam = const Color(0xffdf0e47);
  static const Color jingleJamDark = const Color(0xffc80c3f);

  static const Color primaryTwitterColor = const Color(0xff1da1f2);
  static const Color accentTwitterColor = const Color(0xff14171a);

  static const Color primaryRedditColor = const Color(0xffff4500);
  static const Color accentRedditColor = const Color(0xff5f99cf);

  static const Color primaryDiscordColor = const Color(0xff7289da);
  static const Color accentDiscordColor = const Color(0xff23272a);

  static const Color primaryInstagramColor = const Color(0xff405de6);
  static const Color accentInstagramColor = const Color(0xfffd1d1d);

  static const Color primarySnapchatColor = const Color(0xfffffc00);
  static const Color accentSnapchatColor = const Color(0xff000000);

  static const Color primaryPatreonColor = const Color(0xfff96854);
  static const Color accentPatreonColor = const Color(0xff052d49);

  static const Color humbleBundle = const Color(0xffcb272c);

  static Color get bandcamp => Color(0xff629aa9);

  static const MaterialColor primaryColorPallet = const MaterialColor(
    0xff0094ff,
    const <int, Color>{
      50: const Color(0xFF62bdff),
      100: const Color(0xFF4eb5ff),
      200: const Color(0xFF3badff),
      300: const Color(0xFF27a4ff),
      400: const Color(0xFF149cff),
      500: const Color(0xff0094ff),
      600: const Color(0xff0089eb),
      700: const Color(0xFF007dd8),
      800: const Color(0xFF0072c4),
      900: const Color(0xFF0066b1),
    },
  );

  static const MaterialColor accentColorPalletOld = const MaterialColor(
    0xffff7b30,
    const <int, Color>{
      50: const Color(0xFFffba92),
      100: const Color(0xFFffad7e),
      200: const Color(0xFFffa16b),
      300: const Color(0xFFff9457),
      400: const Color(0xFFff8844),
      500: const Color(0xffff7b30),
      600: const Color(0xffff6e1c),
      700: const Color(0xFFff6209),
      800: const Color(0xFFf45800),
      900: const Color(0xFFe15100),
    },
  );



  static const MaterialColor accentColorPallet = const MaterialColor(
    0xffff8b23,
    const <int, Color>{
      50: const Color( 0xFFffbf85),
      100: const Color(0xFFffb471),
      200: const Color(0xFFffaa5e),
      300: const Color(0xFFffa04a),
      400: const Color(0xFFff9537),
      500: const Color(0xffff8b23),
      600: const Color(0xffff810f),
      700: const Color(0xFFfb7700),
      800: const Color(0xFFe76d00),
      900: const Color(0xFFd46400),
    },
  );

  static double mapTo(Color color) {
    return (color.value / (255 * 255 * 255 * 255)).toDouble();
  }
}

extension YColorExtension on Color {
  Color get greyscale {
    return t.TinyColor(this).greyscale().color;
  }

  Color desaturate(int i) {
    return t.TinyColor(this).desaturate(i).color;
  }

  Color lighten(int l) {
    return t.TinyColor(this).lighten(l).color;
  }

  Color darken(int l) {
    return t.TinyColor(this).darken(l).color;
  }

  Color shade(int l) {
    return t.TinyColor(this).shade(l).color;
  }

  Color tint(int l) {
    return t.TinyColor(this).tint(l).color;
  }

  double get luminance2 =>
      (0.299 * this.red + 0.587 * this.green + 0.114 * this.blue) / 255;

  Color get textColor {
    if (luminance2 > 0.5) {
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
    return t.TinyColor(this).isLight();
  }

  bool get isDark {
    return t.TinyColor(this).isDark();
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

  double contrast(Color c) {
    double l1 = c.luminance2;
    double l2 = this.luminance2;
    if (l1 > l2) {
      return (l1 + 0.05) / (l2 + 0.05);
    } else {
      return (l2 + 0.05) / (l1 + 0.05);
    }
  }
}
