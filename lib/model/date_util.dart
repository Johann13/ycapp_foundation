import 'package:ycapp_foundation/model/y_firestore_timestamp.dart';

DateTime getDate(dynamic v) {
  if (v is Timestamp) {
    return v.toDate();
  } else if (v is int) {
    return DateTime.fromMillisecondsSinceEpoch(v);
  } else if (v is Timestamp) {
    return v.toDate();
  } else if (v is Map) {
    Map date = v;
    if (date.containsKey('_seconds')) {
      return DateTime.fromMillisecondsSinceEpoch((v['_seconds'] as int) * 1000);
    } else {
      return DateTime.fromMillisecondsSinceEpoch((v['seconds'] as int) * 1000);
    }
  } else if (v is DateTime) {
    return v;
  } else if (v is String) {
    return DateTime.parse(v);
  } else {
    return null;
  }
}
