import 'package:flutter/material.dart';

class YcAppTextTheme extends TextTheme {
  YcAppTextTheme({
    bool darkMode = false,
  }) : super(
          headline1: TextStyle(
            height: 1,
            letterSpacing: 1,
            color: darkMode ? Color(0xb3ffffff) : Color(0x8a000000),
          ),
          headline2: TextStyle(
            height: 1,
            letterSpacing: 1,
            color: darkMode ? Color(0xb3ffffff) : Color(0x8a000000),
          ),
          headline3: TextStyle(
            height: 1,
            letterSpacing: 1,
            color: darkMode ? Color(0xb3ffffff) : Color(0x8a000000),
          ),
          headline4: TextStyle(
            height: 1,
            letterSpacing: 1,
            color: darkMode ? Color(0xb3ffffff) : Color(0x8a000000),
          ),
          headline5: TextStyle(
            height: 1,
            letterSpacing: 1,
            color: darkMode ? Color(0xffffffff) : Color(0xdd000000),
          ),
          headline6: TextStyle(
            height: 1,
            letterSpacing: 1,
            color: darkMode ? Color(0xffffffff) : Color(0xdd000000),
          ),
          subtitle1: TextStyle(
            height: 1,
            letterSpacing: 1,
            color: darkMode ? Color(0xffffffff) : Color(0xdd000000),
          ),
          subtitle2: TextStyle(
            height: 1,
            letterSpacing: 1,
            color: darkMode ? Color(0xffffffff) : Color(0xff000000),
          ),
          bodyText1: TextStyle(
            height: 1,
            letterSpacing: 1,
            color: darkMode ? Color(0xffffffff) : Color(0xdd000000),
          ),
          bodyText2: TextStyle(
            height: 1,
            letterSpacing: 1,
            color: darkMode ? Color(0xffffffff) : Color(0xdd000000),
          ),
          caption: TextStyle(
            height: 1,
            letterSpacing: 1,
            color: darkMode ? Color(0xb3ffffff) : Color(0x8a000000),
          ),
          button: TextStyle(
            height: 1,
            letterSpacing: 1,
            color: darkMode ? Color(0xffffffff) : Color(0xdd000000),
          ),
          overline: TextStyle(
            height: 1,
            letterSpacing: 1,
            color: darkMode ? Color(0xffffffff) : Color(0xff000000),
          ),
        );
}
