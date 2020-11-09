import 'package:time_machine/time_machine.dart';
import 'package:timezone/timezone.dart';

class YDates {
  static final TZDateTime jjStartUK = TZDateTime(
    getLocation('Europe/London'),
    DateTime.now().year,
    12,
    1,
    17,
  );
  static final TZDateTime jjEndUK = TZDateTime(
    getLocation('Europe/London'),
    DateTime.now().year + 1,
    1,
    1,
  );
  static final TZDateTime jjEnd = TZDateTime.from(
    jjEndUK,
    getLocation('${DateTimeZone.local}'),
  );
  static final TZDateTime jjStart = TZDateTime.from(
    jjStartUK,
    getLocation('${DateTimeZone.local}'),
  );

  static TZDateTime get now => TZDateTime.now(
        getLocation('${DateTimeZone.local}'),
      );

  static TZDateTime get nowUK => TZDateTime.now(
        getLocation('Europe/London'),
      );

  static bool get isJJ {
    return now.isAfter(jjStart) && now.isBefore(jjEnd);
  }

  static bool get useJJTheme {
    return now.isAfter(TZDateTime(
          getLocation('Europe/London'),
          DateTime.now().year,
          11,
          1,
          17,
        )) &&
        now.isBefore(jjEnd);
  }
}
