import 'package:time_machine/time_machine.dart';
import 'package:timezone/timezone.dart';

class YDates {
  YDates._();

  static final String localTimezone = '${DateTimeZone.local}';
  static final String ukTimezone = 'Europe/London';

  static final TZDateTime jjStartUK = TZDateTime(
    getLocation(ukTimezone),
    DateTime.now().year,
    12,
    1,
    17,
  );
  static final TZDateTime jjEndUK = TZDateTime(
    getLocation(ukTimezone),
    DateTime.now().year + 1,
    1,
    1,
  );
  static final TZDateTime jjEnd = TZDateTime.from(
    jjEndUK,
    getLocation(localTimezone),
  );
  static final TZDateTime jjStart = TZDateTime.from(
    jjStartUK,
    getLocation(localTimezone),
  );

  static TZDateTime get now => TZDateTime.now(
        getLocation(localTimezone),
      );

  static TZDateTime get nowUK => TZDateTime.now(
        getLocation(ukTimezone),
      );

  static bool get isJJ {
    return now.isAfter(jjStart) && now.isBefore(jjEnd);
  }

  static bool get useJJTheme {
    return now.isAfter(TZDateTime(
          getLocation(ukTimezone),
          DateTime.now().year,
          11,
          24,
          17,
        )) &&
        now.isBefore(jjEnd);
  }
}
