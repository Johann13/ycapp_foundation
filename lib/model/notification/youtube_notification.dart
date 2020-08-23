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

  YoutubeNotification(
    this.id,
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
    this.duration,
  );

  factory YoutubeNotification.fromMap(Map<String, dynamic> map) {
    String id = map['id'];
    String channelId = map['channelId'];
    String channelName = map['channelName'];
    String videoId = map['videoId'];
    String videoTitle = map['videoTitle'];
    DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(map['date']));
    DateTime publishedAt;
    if (map.containsKey('publishedMills')) {
      publishedAt = DateTime.fromMillisecondsSinceEpoch(map['publishedMills']);
    }
    String keyString = map['creatorKeys'] ?? '';
    String creatorNames = map['creatorNames'] ?? '';
    List<String> creatorKeys = (map['creatorKeys'] ?? '').split(',');
    String duration = map['duration'] ?? '';
    String creatorListString = map["creator"] ?? '';
    List data = json.decode(creatorListString);
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
    int n;
    String s = '';
    List<YoutubeCreator> temp = [];
    switch (p) {
      case "disable":
        return "";
      case "all":
        s += '\nWith';
        temp = creatorList;
        n = temp.length;
        for (int i = 0; i < n; i++) {
          YoutubeCreator yc = temp[i];
          s += yc.name;
          if (i == n - 2) {
            s += ' and ';
          } else if (i < n - 1) {
            s += ', ';
          }
        }
        return s;
      case "sub":
        s += '\nWith';
        for (YoutubeCreator yc in creatorList) {
          if (creator.contains(yc.key)) {
            temp.add(yc);
          }
        }
        n = temp.length;
        bool useAndMore = temp.length < creatorList.length;
        for (int i = 0; i < n; i++) {
          YoutubeCreator yc = temp[i];
          s += yc.name;
          if (i == n - 2 && !useAndMore) {
            s += ' and ';
          } else if (i < n - 1) {
            s += ', ';
          }
        }
        if (useAndMore) {
          s += ' and more!';
        }
        return s;
      default:
        return '';
    }
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
}

class YoutubeCreator {
  String key;
  String name;

  YoutubeCreator(this.key, this.name);
}
