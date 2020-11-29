import 'package:ycapp_foundation/model/base_model.dart';

abstract class Channel extends BaseModel {
  String channelId;
  String name;
  bool visible;
  String url;
  int creatorCounter;
  int relatedYoutubeChannelCounter;
  int relatedTwitchChannelCounter;

  MainCreator mainCreator;

  List<String> creator;
  List<String> youtube;
  List<String> twitch;
  List<String> podcast;
  List<String> community;

  int type;

  Channel.fromMap(Map<String,dynamic> map) {
    if (map.containsKey('channelId')) {
      channelId = map['channelId'] as String;
    }
    if (map.containsKey('type')) {
      type = map['type'] as int;
    }
    if (map.containsKey('name')) {
      name = map['name'] as String;
    }
    if (map.containsKey('visible')) {
      visible = map['visible'] as bool;
    }
    if (map.containsKey('url')) {
      url = map['url'] as String;
    }
    if (map.containsKey('youtubeCounter')) {
      this.relatedYoutubeChannelCounter = map['youtubeCounter'] as int;
    } else {
      this.relatedYoutubeChannelCounter = 0;
    }
    if (map.containsKey('twitchCounter')) {
      this.relatedTwitchChannelCounter = map['twitchCounter'] as int;
    } else {
      this.relatedTwitchChannelCounter = 0;
    }
    if (map.containsKey('creatorCounter')) {
      this.creatorCounter = map['creatorCounter'] as int;
    } else {
      this.creatorCounter = 0;
    }
    if (map.containsKey('mainCreator')) {
      if (map['mainCreator'] != null) {
        mainCreator =
            MainCreator.fromMap(map['mainCreator'] as Map<String, dynamic>);
      }
    }
    youtube = [];
    if (map.containsKey('youtube')) {
      if (map['youtube'] != null) {
        if (map['youtube'] is Map) {
          Map<String, dynamic> ymap = map['youtube'] as Map<String, dynamic>;
          ymap.keys.forEach((String k) => youtube.add(k));
        } else if (map['youtube'] is List) {
          youtube = map['youtube'] as List<String>;
        }
      }
    }

    twitch = [];
    if (map.containsKey('twitch')) {
      if (map['twitch'] != null) {
        if (map['twitch'] is Map) {
          Map<String, dynamic> tmap = map['twitch'] as Map<String, dynamic>;
          tmap.keys.forEach((k) => twitch.add(k));
        } else if (map['twitch'] is List<String>) {
          twitch = map['twitch'] as List<String>;
        }
      }
    }
    creator = [];
    if (map.containsKey('creator')) {
      if (map['creator'] != null) {
        if (map['creator'] is Map) {
          Map<String, dynamic> cmap = map['creator'] as Map<String, dynamic>;
          cmap.keys.forEach((k) => creator.add(k));
        } else if (map['creator'] is List) {
          creator = map['creator'] as List<String>;
        }
      }
    }
    podcast = [];
    if (map.containsKey('podcast')) {
      if (map['podcast'] != null) {
        if (map['podcast'] is Map) {
          Map<String, dynamic> cmap = map['podcast'] as Map<String, dynamic>;
          cmap.keys.forEach((k) => podcast.add(k));
        } else if (map['podcast'] is List) {
          podcast = map['podcast'] as List<String>;
        }
      }
    }

    community = [];
    if (map.containsKey('community')) {
      if (map['community'] != null) {
        if (map['community'] is Map) {
          Map<String, dynamic> cmap = map['community'] as Map<String, dynamic>;
          cmap.keys.forEach((k) => community.add(k));
        } else if (map['community'] is List) {
          community = map['community'] as List<String>;
        }
      }
    }
  }

  @override
  String get id => channelId;

  Map<String,dynamic> toJson() => <String, dynamic>{
        'channelId': channelId,
        'name': name,
        'visible': visible,
        'url': url,
        'creatorCounter': creatorCounter,
        'relatedYoutubeChannelCounter': relatedYoutubeChannelCounter,
        'relatedTwitchChannelCounter': relatedTwitchChannelCounter,
        'mainCreator': mainCreator?.toJson(),
        'creator': creator,
        'youtube': youtube,
        'twitch': twitch,
        'type': type,
      };
}

class MainCreator {
  String creatorId;
  String name;

  MainCreator.fromMap(Map<String, dynamic> map) {
    if (map.containsKey('creatorId')) {
      creatorId = map['creatorId'] as String;
    }

    if (map.containsKey('name')) {
      name = map['name'] as String;
    }
  }

  Map<String,dynamic> toJson() => <String, dynamic>{
        'creatorId': creatorId,
        'name': name,
      };
}
