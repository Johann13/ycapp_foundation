import 'package:ycapp_foundation/model/date_util.dart';

enum InboxNotificationType { Twitch, Youtube, Other }

class InboxNotification {
  String id;
  InboxNotificationType type;
  String channelId;
  String channelName;
  String title;
  String videoId;
  DateTime date;
  DateTime published;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'type': type.index,
        'channelId': channelId,
        'channelName': channelName,
        'title': title,
        'videoId': videoId,
        'date': date.millisecondsSinceEpoch,
        'published': published.millisecondsSinceEpoch,
      };

  InboxNotification.fromMap(Map<String, dynamic> map) {
    if (map.containsKey('channelId')) {
      channelId = map['channelId'] as String;
    }
    if (map.containsKey('channelName')) {
      channelName = map['channelName'] as String;
    }
    if (map.containsKey('date')) {
      date = getDate(map['date']);
    } else {
      date = DateTime.now();
    }
    if (map.containsKey('publishedMills')) {
      published = getDate(map['publishedMills']);
    } else if (map.containsKey('published')) {
      published = getDate(map['published']);
    }
    if (map.containsKey('title')) {
      title = map['title'] as String;
    }
    if (map.containsKey('videoId')) {
      videoId = map['videoId'] as String;
    }
    if (map.containsKey('type')) {
      if (map['type'] is String) {
        String t = map['type'] as String;
        if (t == 'TwitchChannelLive') {
          type = InboxNotificationType.Twitch;
        } else if (t == 'NewYoutubeVideo') {
          type = InboxNotificationType.Youtube;
        } else {
          type = InboxNotificationType.Other;
        }
      } else if (map['type'] is int) {
        type = InboxNotificationType.values[map['type'] as int];
      } else {
        type = InboxNotificationType.Other;
      }
    } else {
      type = InboxNotificationType.Other;
    }
    if (map.containsKey('id')) {
      id = map['id'] as String;
    } else {
      id = '${date.millisecondsSinceEpoch}';
    }
  }
}

enum ChannelType { Twitch, Youtube, YoutubeVideo }
enum NotificationInterval { Once, Daily, Weekly }

class CustomNotification {
  int id;
  ChannelType type;
  NotificationInterval interval;
  String title;
  String body;
  DateTime date;
  String channelId;

  CustomNotification.fromMap(Map<String, dynamic> map) {
    if (map.containsKey('id')) {
      id = map['id'] as int;
    }
    if (map.containsKey('interval')) {
      interval = NotificationInterval.values[map['interval'] as int];
    }
    if (map.containsKey('type')) {
      type = ChannelType.values[map['type'] as int];
    }
    if (map.containsKey('title')) {
      title = map['title'] as String;
    }
    if (map.containsKey('body')) {
      body = map['body'] as String;
    }
    if (map.containsKey('date')) {
      print(map['date']);
      date = DateTime.fromMillisecondsSinceEpoch(map['date'] as int);
    }
    if (map.containsKey('channelId')) {
      channelId = map['channelId'] as String;
    }
  }

  CustomNotification._internal(
    this.interval,
    this.type,
    this.channelId,
    this.title,
    this.body,
    this.date,
  ) : this.id = DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;

  factory CustomNotification.twitch(
    NotificationInterval interval,
    String channelId,
    String title,
    String body,
    DateTime date,
  ) =>
      CustomNotification._internal(
        interval,
        ChannelType.Twitch,
        channelId,
        title,
        body,
        date,
      );

  factory CustomNotification.youtube(
    NotificationInterval interval,
    String channelId,
    String title,
    String body,
    DateTime date,
  ) =>
      CustomNotification._internal(
        interval,
        ChannelType.Youtube,
        channelId,
        title,
        body,
        date,
      );

  factory CustomNotification.youtubeVideo(
    NotificationInterval interval,
    String channelId,
    String title,
    String body,
    DateTime date,
  ) =>
      CustomNotification._internal(
        interval,
        ChannelType.YoutubeVideo,
        channelId,
        title,
        body,
        date,
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'interval': interval.index,
      'type': type.index,
      'channelId': channelId,
      'title': title,
      'body': body,
      'date': date.toUtc().millisecondsSinceEpoch,
    };
  }

  String get notificationChannel {
    switch (type) {
      case ChannelType.Twitch:
        return 'twitch_notification_channel';
      case ChannelType.Youtube:
        return 'youtube_notification_channel';
      case ChannelType.YoutubeVideo:
        return 'youtube_notification_channel';
      default:
        return 'other_notification_channel';
    }
  }

  String get notificationChannelDesc {
    switch (type) {
      case ChannelType.Twitch:
        return 'Twitch Related Notifications';
      case ChannelType.Youtube:
        return 'Youtube Related Notifications';
      case ChannelType.YoutubeVideo:
        return 'Youtube Related Notifications';
      default:
        return 'Other Notifications';
    }
  }
}
