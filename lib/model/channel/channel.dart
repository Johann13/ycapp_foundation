import 'package:ycapp_foundation/model/base_model.dart';

abstract class Channel extends BaseModel{
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

  Channel.fromMap(Map map) {
    if (map.containsKey('channelId')) {
      channelId = map['channelId'];
    }
    if (map.containsKey('type')) {
      type = map['type'];
    }
    if (map.containsKey('name')) {
      name = map['name'];
    }
    if (map.containsKey('visible')) {
      visible = map['visible'];
    }
    if (map.containsKey('url')) {
      url = map['url'];
    }
    if (map.containsKey('youtubeCounter')) {
      this.relatedYoutubeChannelCounter = map['youtubeCounter'];
    } else {
      this.relatedYoutubeChannelCounter = 0;
    }
    if (map.containsKey('twitchCounter')) {
      this.relatedTwitchChannelCounter = map['twitchCounter'];
    } else {
      this.relatedTwitchChannelCounter = 0;
    }
    if (map.containsKey('creatorCounter')) {
      this.creatorCounter = map['creatorCounter'];
    } else {
      this.creatorCounter = 0;
    }
    if (map.containsKey('mainCreator')) {
      if (map['mainCreator'] != null) {
        mainCreator = MainCreator.fromMap(map['mainCreator']);
      }
    }
    youtube = [];
    if (map.containsKey('youtube')) {
      if (map['youtube'] != null) {
        if (map['youtube'] is Map) {
          Map ymap = map['youtube'];
          ymap.forEach((k, v) => youtube.add(k));
        } else if (map['youtube'] is List) {
          youtube = (map['youtube'] as List).cast<String>();
        }
      }
    }

    twitch = [];
    if (map.containsKey('twitch')) {
      if (map['twitch'] != null) {
        if (map['twitch'] is Map) {
          Map tmap = map['twitch'];
          tmap.forEach((k, v) => twitch.add(k));
        } else if (map['twitch'] is List) {
          twitch = (map['twitch'] as List).cast<String>();
        }
      }
    }
    creator = [];
    if (map.containsKey('creator')) {
      if (map['creator'] != null) {
        if (map['creator'] is Map) {
          Map cmap = map['creator'];
          cmap.forEach((k, v) => creator.add(k));
        } else if (map['creator'] is List) {
          creator = (map['creator'] as List).cast<String>();
        }
      }
    }
    podcast = [];
    if (map.containsKey('podcast')) {
      if (map['podcast'] != null) {
        if (map['podcast'] is Map) {
          Map cmap = map['podcast'];
          cmap.forEach((k, v) => podcast.add(k));
        } else if (map['podcast'] is List) {
          podcast = (map['podcast'] as List).cast<String>();
        }
      }
    }

    community = [];
    if (map.containsKey('community')) {
      if (map['community'] != null) {
        if (map['community'] is Map) {
          Map cmap = map['community'];
          cmap.forEach((k, v) => community.add(k));
        } else if (map['community'] is List) {
          community = (map['community'] as List).cast<String>();
        }
      }
    }
  }

  @override
  String get id => channelId;

  Map toJson() => {
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

  MainCreator.fromMap(Map<dynamic, dynamic> map) {
    if (map.containsKey('creatorId')) {
      creatorId = map['creatorId'];
    }

    if (map.containsKey('name')) {
      name = map['name'];
    }
  }

  Map toJson() => {
    'creatorId': creatorId,
    'name': name,
  };
}
