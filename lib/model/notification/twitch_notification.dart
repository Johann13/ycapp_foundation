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
    String id = map["id"] as String;
    String channelId = map["channelId"] as String;
    String channelName = map["channelName"] as String;
    String gameId = map["gameId"] as String;
    String gameName = map["gameName"] as String;
    String gameBoxArtUrl = map["gameBoxArtUrl"] as String;
    String streamTitle = map["streamTitle"] as String;
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(int.parse(map["date"] as String));
    DateTime startedAt;
    if (map.containsKey("publishedMills")) {
      startedAt = DateTime.fromMillisecondsSinceEpoch(
          int.parse(map["publishedMills"] as String));
    }
    String summary = map["summary"] as String ?? '';
    String creatorNames = map["creatorNames"] as String ?? '';
    List<String> creatorKeys = (map["creatorKeys"] as String ?? '').split(",");
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
