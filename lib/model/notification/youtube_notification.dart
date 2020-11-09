import 'dart:convert';
import 'dart:core';

import 'package:ycapp_foundation/prefs/prefs.dart';

class YoutubeNotification {
  String id;
  String channelId;
  String channelName;
  String videoId;
  String videoTitle;
  DateTime date;
  DateTime publishedAt;
  String creatorNames;

  String keyString;
  List<String> creatorKeys;
  List<YoutubeCreator> creatorList;
  String creatorListString;

  String duration;

  YoutubeNotification(this.id,
      this.channelId,
      this.channelName,
      this.videoId,
      this.videoTitle,
      this.date,
      this.publishedAt,
      this.creatorNames,
      this.keyString,
      this.creatorKeys,
      this.creatorList,
      this.creatorListString,
      this.duration,);

  factory YoutubeNotification.fromMap(Map<String, String> map) {
    String id = map['id'];
    String channelId = map['channelId'];
    String channelName = map['channelName'];
    String videoId = map['videoId'];
    String videoTitle = map['videoTitle'];
    DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(map['date']));
    DateTime publishedAt;
    if (map.containsKey('publishedMills')) {
      publishedAt =
          DateTime.fromMillisecondsSinceEpoch(int.parse(map['publishedMills']));
    }
    String keyString = map['creatorKeys'] ?? '';
    String creatorNames = map['creatorNames'] ?? '';
    List<String> creatorKeys = (keyString ?? '').split(',');
    String duration = map['duration'] ?? '';
    String creatorListString = map["creator"] ?? '';
    print(creatorListString);
    List data = json.decode(creatorListString.replaceAll("'",'"'));
    List<YoutubeCreator> creatorList =
    data.map((d) => YoutubeCreator(d['key'], d['name'])).toList();
    return YoutubeNotification(
      id,
      channelId,
      channelName,
      videoId,
      videoTitle,
      date,
      publishedAt,
      creatorNames,
      keyString,
      creatorKeys,
      creatorList,
      creatorListString,
      duration,
    );
  }

  Future<String> get creatorNameText async {
    List<String> creator = await Prefs.getStringList('creatorSubscriptions');
    String p = await Prefs.getString("youtube_notification_wiitv", "sub");
    String s = '';
    List<String> names = [];
    for (YoutubeCreator c in creatorList) {
      if (p == "all" || (p == "sub" && creator.contains(c.key))) {
        names.add(c.name);
      }
    }
    s += "\nWith ";
    int n = names.length;
    bool useAndMore = n < creatorList.length && p == "all";
    for (int i = 0; i < n; i++) {
      s += names[i];
      if (i == n - 2 && !useAndMore) {
        s += " and ";
      } else if (i < n - 1) {
        s += ", ";
      }
    }
    if (useAndMore) {
      s += " and more!";
    }
    return s;
  }

  int get notificationId {
    if (publishedAt != null) {
      return ((date.millisecondsSinceEpoch ~/ 1000) +
          (publishedAt.millisecondsSinceEpoch ~/ 1000)) ~/
          2;
    } else {
      return date.millisecondsSinceEpoch ~/ 1000;
    }
  }

  Map<String, String> toJson() {
    return {
      "id": id,
      "channelId": channelId,
      "channelName": channelName,
      "duration": duration,
      "videoId": videoId,
      "videoTitle": videoTitle,
      "date": '${DateTime
          .now()
          .millisecondsSinceEpoch}',
      "publishedMills": '${DateTime
          .now()
          .millisecondsSinceEpoch}',
      "creatorNames": creatorNames,
      "creatorKeys": keyString,
      "creator": creatorListString,
    };
  }
}

class YoutubeCreator {
  String key;
  String name;

  YoutubeCreator(this.key, this.name);

  Map<String, String> toJson() => {'name': name, 'key': key};
}
