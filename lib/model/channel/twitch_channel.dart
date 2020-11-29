import 'package:ycapp_foundation/model/channel/channel.dart';
import 'package:ycapp_foundation/model/date_util.dart';

class TwitchChannel extends Channel {
  TwitchData twitchData;
  TwitchStream stream;
  TwitchStream prevStream;
  TwitchGame game;
  TwitchGame prevGame;

  TwitchChannel.fromMap(Map<String, dynamic> map)
      : twitchData =
            TwitchData.fromMap(map['twitchData'] as Map<String, dynamic>),
        super.fromMap(map) {
    map['stream'] == null
        ? stream = null
        : stream = TwitchStream.fromMap(map['stream'] as Map<String, dynamic>);
    map['prevStream'] == null
        ? prevStream = null
        : prevStream =
            TwitchStream.fromMap(map['prevStream'] as Map<String, dynamic>);
    map['game'] == null
        ? game = null
        : game = TwitchGame.fromMap(map['game'] as Map<String, dynamic>);
    map['prevGame'] == null
        ? prevGame = null
        : prevGame =
            TwitchGame.fromMap(map['prevGame'] as Map<String, dynamic>);
  }

  bool get isMainChannel => channelId == '20786541';

  double get followerPrevViewerRatio {
    if (prevStream == null) {
      return 0;
    }
    return prevStream.viewerCount / twitchData.followerCount;
  }

  bool get isLive => stream != null;

  bool get isCinema {
    if (!isLive) {
      return false;
    }

    String title = stream.title.toLowerCase();
    String name = this.name.toLowerCase();
    String cinema = 'cinema';
    bool containsCinema = title.contains(cinema);

    bool containsName = false;

    a:
    for (int i = name.length; i > 0; i--) {
      if (title.contains(name.substring(0, i - 1))) {
        containsName = true;
        break a;
      }
    }

    List<String> list = [];
    String c1 = '${name}Cinema';
    String c2 = '${twitchData.displayName}Cinema';
    String c3 = '${name} Cinema';
    String c4 = '${twitchData.displayName} Cinema';
    list.addAll([c1, c2, c3, c4]);
    for (int i = 3; i <= 5; i++) {
      if (name.length >= i) {
        list.add('${name.substring(0, i)}Cinema');
        list.add('${name.substring(0, i)} Cinema');
      }
      if (twitchData.displayName.length >= i) {
        list.add('${twitchData.displayName.substring(0, i)}Cinema');
        list.add('${twitchData.displayName.substring(0, i)} Cinema');
      }
    }
    return (containsCinema && containsName) ||
        list.any((c) => title.toLowerCase().contains(c.toLowerCase()));
  }

  String get _live {
    String title = stream.title.toLowerCase();
    String name = this.name.toLowerCase();
    String shortName;
    a:
    for (int i = name.length; i > 0; i--) {
      if (title.contains(name.substring(0, i - 1))) {
        shortName =
            '${name.substring(0, 1).toUpperCase()}${name.substring(1, i - 1)}';
        break a;
      }
    }

    return shortName != null ? '${shortName}Cinema' : 'Live';
  }

  String get liveText {
    if (!isLive) {
      return '';
    }
    if (!isCinema) {
      return 'Live';
    }

    String title = stream.title;
    List<String> list = [];
    String c1 = '${name}Cinema';
    String c2 = '${twitchData.displayName}Cinema';
    String c3 = '${name} Cinema';
    String c4 = '${twitchData.displayName} Cinema';
    list.addAll([c1, c2, c3, c4]);
    for (int i = 3; i <= 5; i++) {
      if (name.length >= i) {
        list.add('${name.substring(0, i)}Cinema');
        list.add('${name.substring(0, i)} Cinema');
      }
      if (twitchData.displayName.length >= i) {
        list.add('${twitchData.displayName.substring(0, i)}Cinema');
        list.add('${twitchData.displayName.substring(0, i)} Cinema');
      }
    }
    return list.firstWhere((c) => title.toLowerCase().contains(c.toLowerCase()),
        orElse: () => _live);
  }

  bool get hasPrevStream => prevStream != null;

  DateTime get lastLive {
    if (isLive) {
      return stream.startedAt;
    }
    if (hasPrevStream) {
      return prevStream.startedAt;
    }
    return null;
  }

  @override
  String toString() {
    return '${toMap()}';
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'twitchData': twitchData?.toMap(),
        'stream': stream?.toMap(),
        'prevStream': prevStream?.toMap(),
        'game': game?.toMap(),
        'prevGame': prevGame?.toMap(),
      };

  Map<String,dynamic> toJson() => super.toJson()
    ..addAll(<String, dynamic>{
      'twitchData': twitchData?.toMap(),
      'stream': stream?.toMap(),
      'prevStream': prevStream?.toMap(),
      'game': game?.toMap(),
      'prevGame': prevGame?.toMap(),
    });
}

class TwitchData {
  String twitchId;
  String name;
  String displayName;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  String profileImage;
  String offlineImage;
  String _profileBanner;
  int viewCount;
  int followerCount;

  TwitchData.fromMap(Map map) {
    if (map == null) {
      return;
    }
    if (map.containsKey('twitchId')) {
      this.twitchId = map['twitchId'] as String;
    }
    if (map.containsKey('name')) {
      this.name = map['name'] as String;
    }
    if (map.containsKey('displayName')) {
      this.displayName = map['displayName'] as String;
    }
    if (map.containsKey('description')) {
      this.description = map['description'] as String;
    }
    if (map.containsKey('createdAt')) {
      this.createdAt = getDate(map['createdAt']);
    }
    if (map.containsKey('updatedAt')) {
      this.updatedAt = getDate(map['updatedAt']);
    }
    if (map.containsKey('profileImage')) {
      this.profileImage = map['profileImage'] as String;
    }
    if (map.containsKey('offlineImage')) {
      this.offlineImage = map['offlineImage'] as String;
    }
    if (map.containsKey('profileBanner')) {
      this._profileBanner = map['profileBanner'] as String;
    }
    if (map.containsKey('viewCount')) {
      this.viewCount = map['viewCount'] as int;
    }
    if (map.containsKey('followerCount')) {
      this.followerCount = map['followerCount'] as int;
    }
  }

  String get profileBanner {
    if (_profileBanner == null || _profileBanner.isEmpty) {
      return offlineImage;
    } else {
      return _profileBanner;
    }
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'twitchId': twitchId,
        'name': name,
        'displayName': displayName,
        'description': description,
        'createdAt': createdAt?.millisecondsSinceEpoch,
        'updatedAt': updatedAt?.millisecondsSinceEpoch,
        'profileImage': profileImage,
        'offlineImage': offlineImage,
        'profileBanner': profileBanner,
        'viewCount': viewCount,
        'followerCount': followerCount,
      };
}

class TwitchStream {
  String streamId;
  String gameId;
  DateTime startedAt;
  DateTime _endedAt;
  String _thumbnail;
  String title;
  String twitchId;
  int viewerCount;

  TwitchStream.fromMap(Map map) {
    if (map == null) return;
    if (map.containsKey('streamId')) {
      streamId = map['streamId'] as String;
    }
    if (map.containsKey('gameId')) {
      gameId = map['gameId'] as String;
    }
    if (map.containsKey('startedAt')) {
      startedAt = getDate(map['startedAt']);
    }
    if (map.containsKey('thumbnail')) {
      _thumbnail = map['thumbnail'] as String;
    }
    if (map.containsKey('title')) {
      title = map['title'] as String;
    }
    if (map.containsKey('twitchId')) {
      twitchId = map['twitchId'] as String;
    }
    if (map.containsKey('viewerCount')) {
      viewerCount = map['viewerCount'] as int;
    }
    if (map.containsKey('endedAt')) {
      _endedAt = getDate(map['endedAt']);
    }
  }

  String getThumbnail(int w, int h) {
    return _thumbnail
        .replaceFirst('{width}', '$w')
        .replaceFirst('{height}', '$h');
  }

  String getThumbnailByHeight(int h) {
    return getThumbnail(((h / 9) * 16).floor(), h);
  }

  String getThumbnailByWidth(int w) {
    return getThumbnail(w, ((w / 16) * 9).round());
  }

  DateTime get endedAt {
    if (_endedAt != null) {
      return _endedAt;
    } else {
      return startedAt;
    }
  }

  String get before {
    DateTime today = DateTime.now();
    Duration duration = today.difference(startedAt);

    int min = duration.inMinutes.remainder(60).toInt();
    int h = duration.inHours.remainder(24).toInt();

    if (h == 0) {
      return '$min mins ago';
    }

    return '${twoDigits(h)}:${twoDigits(min)}  hours ago';
  }

  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'streamId': streamId,
        'gameId': gameId,
        'startedAt': startedAt?.millisecondsSinceEpoch,
        'endedAt': _endedAt?.millisecondsSinceEpoch,
        'thumbnail': _thumbnail,
        'title': title,
        'twitchId': twitchId,
        'viewerCount': viewerCount,
      };
}

class TwitchGame {
  String thumbnail;
  String gameId;
  String name;

  TwitchGame.fromMap(Map map) {
    if (map == null) return;
    if (map.containsKey('box_art_url')) {
      thumbnail = map['box_art_url'] as String;
    }
    if (map.containsKey('id')) {
      gameId = map['id'] as String;
    }
    if (map.containsKey('name')) {
      name = map['name'] as String;
    }
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'thumbnail': thumbnail,
        'gameId': gameId,
        'name': name,
      };
}

class TwitchVideo {
  String duration;
  DateTime publishedAt;
  String _thumbnail;
  String title;
  String twitchId;
  String url;
  String videoId;
  int viewCount;

  TwitchVideo.fromMap(Map map) {
    if (map.containsKey('duration')) {
      this.duration = parseTime(map['duration'] as String);
    }
    if (map.containsKey('publishedAt'))
      this.publishedAt = getDate(map['publishedAt']);
    if (map.containsKey('thumbnail'))
      this._thumbnail = map['thumbnail'] as String;
    if (map.containsKey('title')) this.title = map['title'] as String;
    if (map.containsKey('twitchId')) this.twitchId = map['twitchId'] as String;
    if (map.containsKey('url')) this.url = map['url'] as String;
    if (map.containsKey('videoId')) this.videoId = map['videoId'] as String;
    if (map.containsKey('viewCount')) this.viewCount = map['viewCount'] as int;
  }

  String getThumbnail(int w, int h) {
    return _thumbnail
        .replaceFirst('%{width}', '$w')
        .replaceFirst('%{height}', '$h');
  }

  String getThumbnailByHeight(int h) {
    return getThumbnail(((h / 9) * 16).floor(), h);
  }

  String get diff {
    String diff;
    int min = DateTime.now().difference(publishedAt).inMinutes;
    if (min < 1) {
      diff = 'Now';
    } else if (min < 60) {
      diff = '$min minutes ago';
    } else if (min < 60 * 24) {
      diff = '${DateTime.now().difference(publishedAt).inHours} hours ago';
    } else {
      diff = '${DateTime.now().difference(publishedAt).inDays} days ago';
    }
    return diff;
  }

  String parseTime(String time) {
    if (time == null) {
      return 'no time found';
    }
    String n = time
        .replaceAll('D', '-')
        .replaceAll('H', '-')
        .replaceAll('M', '-')
        .replaceAll('S', '-')
        .replaceAll('d', '-')
        .replaceAll('h', '-')
        .replaceAll('m', '-')
        .replaceAll('s', '-');
    List<String> list = n.split('-');
    for (int i = 0; i < list.length; i++) {
      if (list[i].length == 1) {
        list[i] = '0${list[i]}';
      }
    }
    list.removeLast();
    return list
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll(',', ':');
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'duration': duration,
        'publishedAt': publishedAt.millisecondsSinceEpoch,
        'thumbnail': _thumbnail,
        'title': title,
        'twitchId': twitchId,
        'url': url,
        'videoId': videoId,
        'viewCount': viewCount,
      };
}

class TwitchClip {
  DateTime publishedAt;
  String _thumbnail;
  String title;
  String twitchId;
  String url;
  String videoId;
  int viewCount;

  TwitchClip.fromMap(Map map) {
    if (map.containsKey('publishedAt'))
      this.publishedAt = getDate(map['publishedAt']);
    if (map.containsKey('thumbnail'))
      this._thumbnail = map['thumbnail'] as String;
    if (map.containsKey('title')) this.title = map['title'] as String;
    if (map.containsKey('twitchId')) this.twitchId = map['twitchId'] as String;
    if (map.containsKey('url')) this.url = map['url'] as String;
    if (map.containsKey('videoId')) this.videoId = map['videoId'] as String;
    if (map.containsKey('viewCount')) this.viewCount = map['viewCount'] as int;
  }

  String getThumbnail(int w, int h) {
    return _thumbnail
        .replaceFirst('%{width}', '$w')
        .replaceFirst('%{height}', '$h');
  }

  String getThumbnailByHeight(int h) {
    return getThumbnail(((h / 9) * 16).floor(), h);
  }

  String get diff {
    String diff;
    int min = DateTime.now().difference(publishedAt).inMinutes;
    if (min < 1) {
      diff = 'Now';
    } else if (min < 60) {
      diff = '$min minutes ago';
    } else if (min < 60 * 24) {
      diff = '${DateTime.now().difference(publishedAt).inHours} hours ago';
    } else {
      diff = '${DateTime.now().difference(publishedAt).inDays} days ago';
    }
    return diff;
  }

  String parseTime(String time) {
    if (time == null) {
      return 'no time found';
    }
    String n = time
        .replaceAll('D', '-')
        .replaceAll('H', '-')
        .replaceAll('M', '-')
        .replaceAll('S', '-')
        .replaceAll('d', '-')
        .replaceAll('h', '-')
        .replaceAll('m', '-')
        .replaceAll('s', '-');
    List<String> list = n.split('-');
    for (int i = 0; i < list.length; i++) {
      if (list[i].length == 1) {
        list[i] = '0${list[i]}';
      }
    }
    list.removeLast();
    return list
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll(',', ':');
  }
}

class TwitchFollows {
  int total;
  List<TwitchChannelFollow> list;

  TwitchFollows(Map map) {
    if (map.containsKey('total')) {
      total = map['total'] as int;
    }
    if (map.containsKey('data')) {
      List<Map<String, dynamic>> l = map['data'] as List<Map<String, dynamic>>;
      list = l.map((d) => TwitchChannelFollow(d)).toList();
    }
  }
}

class TwitchChannelFollow {
  String id;
  String mainCreatorId;
  String name;
  DateTime date;
  int diff;

  TwitchChannelFollow(Map map) {
    if (map.containsKey('id')) {
      id = map['id'] as String;
    }
    if (map.containsKey('mainCreatorId')) {
      mainCreatorId = map['mainCreatorId'] as String;
    }
    if (map.containsKey('name')) {
      name = map['name'] as String;
    }
    if (map.containsKey('date')) {
      date = getDate(map['mills']);
    }
    if (map.containsKey('diff')) {
      diff = map['diff'] as int;
    }
  }
}
