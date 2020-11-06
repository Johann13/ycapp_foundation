import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ycapp_foundation/model/base_model.dart';
import 'package:ycapp_foundation/model/creator/creator_images.dart';
import 'package:ycapp_foundation/model/creator/creator_links.dart';
import 'package:ycapp_foundation/model/date_util.dart';

class Creator extends BaseModel {
  String creatorId;
  String _name;
  String _desc;
  bool visible;
  Color colorPrimary;
  Color colorAccent;
  List<Color> colorsAppbar;

  int youtubeChannelCounter;
  int twitchChannelCounter;
  int creatorCounter;

  List<String> youtube;

  List<String> twitch;

  List<String> creator;

  List<String> podcast;

  List<String> community;
  String communityRole;

  Images images;
  String _channelPref;

  // ignore: unused_field
  String _banner;

  // ignore: unused_field
  String _profile;
  List<Link> links;

  int type;

  bool useRainbow;

  DateTime lastLive;

  Creator.fromMap(Map map) {
    if (map.containsKey('creatorId')) {
      this.creatorId = map['creatorId'];
    }
    if (map.containsKey('name')) {
      this._name = map['name'];
    }
    if (map.containsKey('desc')) {
      _desc = map['desc'];
    }
    if (map.containsKey('banner')) {
      _banner = map['banner'];
    }
    if (map.containsKey('thumbnail')) {
      _profile = map['thumbnail'];
    }
    if (map.containsKey('visible')) {
      this.visible = map['visible'];
    }
    if (map.containsKey('color1')) {
      String c = map['color1'];
      if (c.startsWith('#')) {
        c = c.substring(1);
      }
      if (c.length < 8) {
        c = 'ff$c';
      }
      if (c.length == 8 && c != 'ff0094ff' && c != 'ffff7b30') {
        this.colorPrimary = Color(int.parse(c, radix: 16));
      }
    } else if (map.containsKey('colorPrimary')) {
      String c = map['colorPrimary'];
      if (c.startsWith('#')) {
        c = c.substring(1);
      }
      if (c.length < 8) {
        c = 'ff$c';
      }
      if (c.length == 8 && c != 'ff0094ff' && c != 'ffff7b30') {
        this.colorPrimary = Color(int.parse(c, radix: 16));
      }
    }

    if (map.containsKey('color2')) {
      String c = map['color2'];
      if (c.startsWith('#')) {
        c = c.substring(1);
      }
      if (c.length < 8) {
        c = 'ff$c';
      }
      if (c.length == 8 && c != 'ff0094ff' && c != 'ffff7b30') {
        this.colorAccent = Color(int.parse(c, radix: 16));
      }
    } else if (map.containsKey('colorSecondary')) {
      String c = map['colorSecondary'];
      if (c.startsWith('#')) {
        c = c.substring(1);
      }
      if (c.length < 8) {
        c = 'ff$c';
      }
      if (c.length == 8 && c != 'ff0094ff' && c != 'ffff7b30') {
        this.colorAccent = Color(int.parse(c, radix: 16));
      }
    }

    if (map.containsKey('colorsAppbar')) {
      if (map['colorsAppbar'] is List || map['colorsAppbar'] is String) {
        List<String> hex;
        if (map['colorsAppbar'] is List) {
          hex = (map['colorsAppbar'] as List).cast<String>();
        } else {
          hex = (map['colorsAppbar'] as String).split(',').toList();
        }

        if (hex != null) {
          if (hex.isNotEmpty) {
            colorsAppbar = hex
                .map((c) {
                  if (c.startsWith('#')) {
                    c = c.substring(1);
                  }
                  if (c.length < 8) {
                    c = 'ff$c';
                  }
                  if (c.length == 8) {
                    return Color(int.parse(c, radix: 16));
                  }
                  return null;
                })
                .where((c) => c != null)
                .toList();
          }
        }
      }
    }

    if (map.containsKey('youtubeCounter')) {
      this.youtubeChannelCounter = map['youtubeCounter'];
    } else {
      this.youtubeChannelCounter = 0;
    }
    if (map.containsKey('twitchCounter')) {
      this.twitchChannelCounter = map['twitchCounter'];
    } else {
      this.twitchChannelCounter = 0;
    }
    if (map.containsKey('creatorCounter')) {
      this.creatorCounter = map['creatorCounter'];
    } else {
      this.creatorCounter = 0;
    }

    if (map.containsKey('channelPref')) {
      _channelPref = map['channelPref'];
    }

    if (map.containsKey('type')) {
      type = map['type'];
    } else {
      type = 1;
    }

    if (map.containsKey('useRainbow')) {
      useRainbow = map['useRainbow'];
    } else {
      useRainbow = false;
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

    if (map.containsKey('communityRole')) {
      communityRole = map['communityRole'];
    }

    if (map.containsKey('channelImages')) {
      this.images = Images(map['channelImages']);
    }

    links = [];
    if (map.containsKey('links')) {
      if (map['links'] is List) {
        List list = map['links'] as List;
        links = [];
        list.forEach((item) => links.add(Link(item)));
      }
    }

    if (map.containsKey('lastLive')) {
      lastLive = getDate(map['lastLive']);
    }
  }

  String get name {
    DateTime now = DateTime.now();
    int month = now.month;
    int day = now.day;
    if (day == 1 && month == DateTime.april) {
      if (_name == 'Ben') {
        return _name;
      }
      return 'Tom';
    }
    return _name;
  }

  String get realName => _name;

  String get creatorBanner => _channelBanner;

  String get profileImage => _channelProfile;

  String get _channelBanner {
    if (_channelPref == null) {
      if (images.twitchImages.banner.isNotEmpty) {
        return images.twitchImages.banner;
      } else if (images.youtubeImages.banner.medium.isNotEmpty) {
        return images.youtubeImages.banner.medium;
      } else {
        return _banner;
      }
    } else {
      if (images.twitchImages.banner.isNotEmpty && _channelPref == 'twitch') {
        return images.twitchImages.banner;
      } else if (images.youtubeImages.banner.medium.isNotEmpty &&
          _channelPref == 'youtube') {
        return images.youtubeImages.banner.medium;
      } else {
        return _banner;
      }
    }
  }

  String get _channelProfile {
    if (_channelPref == null) {
      if (images.twitchImages.profile.isNotEmpty) {
        return images.twitchImages.profile;
      } else if (images.youtubeImages.profile.medium.isNotEmpty) {
        return images.youtubeImages.profile.medium;
      } else {
        return _profile;
      }
    } else {
      if (images.twitchImages.profile.isNotEmpty && _channelPref == 'twitch') {
        return images.twitchImages.profile;
      } else if (images.youtubeImages.profile.medium.isNotEmpty &&
          _channelPref == 'youtube') {
        return images.youtubeImages.profile.medium;
      } else {
        return _profile;
      }
    }
  }

  String get desc {
    if (_desc != null) {
      return _desc;
    } else {
      return 'No Description found.';
    }
  }

  set desc(String desc) => this._desc = desc;

  List<Link> _getLinkByType(String type) {
    return links.where((link) => link.type == type).toList();
  }

  bool hasLinksWithType(String type) {
    return _getLinkByType(type).isNotEmpty;
  }

  bool hasOnlyOneLinkWithType(String type) {
    return _getLinkByType(type).length == 1;
  }

  bool hasAtMostOneLinkWithType(String type) {
    return _getLinkByType(type).length <= 1;
  }

  bool get hasAnyLinks {
    if (links != null) {
      return links.isNotEmpty;
    } else {
      return false;
    }
  }

  bool get hasNoLinks => !hasAnyLinks;

  /*
  bool get hasOnlyOneLinkOfEachType =>
      hasAtMostOneLinkWithType('merch') &&
      hasAtMostOneLinkWithType('twitter') &&
      hasAtMostOneLinkWithType('reddit') &&
      hasAtMostOneLinkWithType('discord');

  bool get areLinkListLengthTheSame =>
      merchLinks.length == redditLinks.length &&
      redditLinks.length == twitterLinks.length &&
      twitterLinks.length == discordLinks.length;

  Map<String, List<Link>> get allLinks {
    List<_LinkListEntry> list = [
      _LinkListEntry('Merch', merchLinks),
      _LinkListEntry('Twitter', twitterLinks),
      _LinkListEntry('Reddit', redditLinks),
      _LinkListEntry('Discord', discordLinks),
    ];

    list.sort((a, b) => a.list.length.compareTo(b.list.length));

    return Map.fromIterable(list, key: (e) => e.name, value: (e) => e.list);
  }*/

  List<Link> get merchLinks {
    return _getLinkByType('merch');
  }

  List<Link> get redditLinks {
    return _getLinkByType('reddit');
  }

  List<Link> get twitterLinks {
    return _getLinkByType('twitter');
  }

  List<Link> get discordLinks {
    return _getLinkByType('discord');
  }

  List<Link> get instagramLinks {
    return _getLinkByType('instagram');
  }

  List<Link> get snapchatLinks {
    return _getLinkByType('snapchat');
  }

  List<Link> get patreonLinks {
    return _getLinkByType('patreon');
  }

  List<Link> get websiteLinks {
    return _getLinkByType('website');
  }

  List<Link> get otherLinks {
    return _getLinkByType('other');
  }

  List<Link> get bandcampLinks {
    return _getLinkByType('bandcamp');
  }

  List<List<Link>> get orderedLinks {
    List<List<Link>> list = [];
    if (merchLinks.isNotEmpty) {
      list.add(merchLinks);
    }
    if (twitterLinks.isNotEmpty) {
      list.add(twitterLinks);
    }
    if (redditLinks.isNotEmpty) {
      list.add(redditLinks);
    }
    if (discordLinks.isNotEmpty) {
      list.add(discordLinks);
    }
    if (patreonLinks.isNotEmpty) {
      list.add(patreonLinks);
    }
    if (snapchatLinks.isNotEmpty) {
      list.add(snapchatLinks);
    }
    if (instagramLinks.isNotEmpty) {
      list.add(instagramLinks);
    }
    if (bandcampLinks.isNotEmpty) {
      list.add(bandcampLinks);
    }
    if (websiteLinks.isNotEmpty) {
      list.add(websiteLinks);
    }
    if (otherLinks.isNotEmpty) {
      list.add(otherLinks);
    }

    return list;

    /*
    return [
      merchLinks,
      twitterLinks,
      redditLinks,
      discordLinks,
      patreonLinks,
      snapchatLinks,
      instagramLinks,
      websiteLinks,
      otherLinks,
    ];*/
  }

  String get channelPref => _channelPref;

  @override
  String get id => creatorId;

  Map toJson() => {
        'creatorId': creatorId,
        'name': _name,
        'desc': desc,
        'visible': visible,
        'color1': colorPrimary?.value?.toRadixString(16),
        'color2': colorAccent?.value?.toRadixString(16),
        'colorsAppbar':
            colorsAppbar?.map((c) => c.value.toRadixString(16))?.toList(),
        'youtubeCounter': youtubeChannelCounter,
        'twitchCounter': twitchChannelCounter,
        'creatorCounter': creatorCounter,
        'youtube': youtube,
        'twitch': twitch,
        'creator': creator,
        'channelImages': images?.toJson(),
        'channelPref': _channelPref,
        'banner': _banner,
        'thumbnail': _profile,
        'links': links?.map((l) => l.toJson())?.toList(),
        'type': type,
        'useRainbow': useRainbow,
      };

/*
  Link get merch {
    if (hasLinksWithType('merch')) {
      return _getLinkByType('merch')[0];
    }
    return null;
  }

  Link get reddit {
    if (hasLinksWithType('reddit')) {
      return _getLinkByType('reddit')[0];
    }
    return null;
  }

  Link get twitter {
    if (hasLinksWithType('twitter')) {
      return _getLinkByType('twitter')[0];
    }
    return null;
  }

  Link get discord {
    if (hasLinksWithType('discord')) {
      return _getLinkByType('discord')[0];
    }
    return null;
  }*/
}
