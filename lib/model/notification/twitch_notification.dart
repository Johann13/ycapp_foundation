class TwitchNotification {
  String id;
  String channelId;
  String channelName;
  String gameId;
  String gameName;
  String gameBoxArtUrl;
  String streamTitle;
  String _summary;
  DateTime date;
  DateTime startedAt;
  String creatorNames;
  List<String> creatorKeys;

  TwitchNotification(
    this.id,
    this.channelId,
    this.channelName,
    this.gameId,
    this.gameName,
    this.gameBoxArtUrl,
    this.streamTitle,
    this._summary,
    this.date,
    this.startedAt,
    this.creatorNames,
    this.creatorKeys,
  );

  factory TwitchNotification.fromMap(Map<String, dynamic> map) {
    String id = map["id"];
    String channelId = map["channelId"];
    String channelName = map["channelName"];
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
    return TwitchNotification(
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
