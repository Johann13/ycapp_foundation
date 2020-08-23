import 'dart:core';

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
    String id = map["id"];
    String channelId = map["channelId"];
    Sring channelName = map["channelName"];
    String gameId = map["gameId"];
    String gameName = map["gameName"];
    String gameBoxArtUrl = map["gameBoxArtUrl"];
    String streamTitle = map["streamTitle"];
    DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(map["date"]));
    DateTime startedAt;
    if (map.containsKey("publishedMills")) {
      startedAt =
          DateTime.fromMillisecondsSinceEpoch(int.parse(map["publishedMills"]));
    }
    String summary = map["summary"] ?? '';
    String creatorNames = map["creatorNames"] ?? '';
    List<String> creatorKeys = (map["creatorKeys"] ?? '').split(",");
    return YoutubeNotification(
      id,
      channelId,
      channelName,
      gameId,
      gameName,
      gameBoxArtUrl,
      streamTitle,
      summary,
      date,
      startedAt,
      creatorNames,
      creatorKeys,
    );
  }

  String get summery {
    return _summary ?? channelName + " went live!";
  }

  int get notificationId {
    if (startedAt != null) {
      return (((date.millisecondsSinceEpoch ~/ 1000) +
              (startedAt.millisecondsSinceEpoch ~/ 1000)) ~/
          2);
    } else {
      return date.millisecondsSinceEpoch ~/ 1000;
    }
  }

  bool get isCollab {
    if (channelName == null) {
      return false;
    }
    if (channelName.isEmpty) {
      return false;
    }
    if (creatorKeys == null) {
      return false;
    }
    if (creatorKeys.isEmpty) {
      return false;
    }
    return true;
  }
}

class YoutubeCreator {
  String key;
  String name;
}
