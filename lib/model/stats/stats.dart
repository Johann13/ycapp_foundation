import 'package:ycapp_foundation/model/channel/twitch_channel.dart';
import 'package:ycapp_foundation/model/channel/youtube_channel.dart';
import 'package:ycapp_foundation/model/creator/creator.dart';
import 'package:ycapp_foundation/model/stats/user.dart';

class StatCount<T> {
  T t;
  double count;

  StatCount(this.t, this.count);
}

class ChannelRelation {
  TwitchChannel twitchChannel;
  YoutubeChannel youtubeChannel;

  ChannelRelation(this.twitchChannel, this.youtubeChannel);
}

class Stats {
  final List<User> _user;
  List<StatCount<String>> _country = [];
  List<StatCount<String>> _lang = [];

  Stats(this._user) {
    _country = _calcCountry();
    _lang = _calcLang();
  }

  int get userCount => _user.length;

  List<User> get user => _user;

  List<StatCount<String>> get country =>
      _country.where((c) => c.count >= 0.02).toList();

  List<StatCount<String>> get lang =>
      _lang.where((c) => c.count >= 0.02).toList();

  List<StatCount> _calcCountry() {
    Map<String, double> map = {};
    _user.forEach((u) {
      if (map.containsKey(u.country)) {
        map[u.country] += 1;
      } else {
        map[u.country] = 1;
      }
    });
    List<StatCount<String>> list = [];
    map.forEach((key, v) => list.add(StatCount(key, v / userCount)));
    list.sort((a, b) => b.count.compareTo(a.count));
    return list;
  }

  List<StatCount<String>> _calcLang() {
    Map<String, double> map = {};
    _user.forEach((u) {
      if (map.containsKey(u.lang)) {
        map[u.lang] += 1;
      } else {
        map[u.lang] = 1;
      }
    });
    List<StatCount<String>> list = [];
    map.forEach((key, v) => list.add(StatCount(key, v / userCount)));
    list.sort((a, b) => b.count.compareTo(a.count));
    return list;
  }

  List<User> getUserByCreatorSub(String creatorId) {
    return _getUserBy(
      (u) => u.data.creator.contains(creatorId),
    );
  }

  List<User> getUserByTwitchSub(String twitchId) {
    return _getUserBy(
      (u) => u.data.twitch.contains(twitchId),
    );
  }

  List<User> getUserByYoutubeSub(String youtubeId) {
    return _getUserBy(
      (u) => u.data.youtube.contains(youtubeId),
    );
  }

  List<User> getUserByCreatorSubs(String creatorId1, String creatorId2) {
    return _getUserBy(
      (u) =>
          u.data.creator.contains(creatorId1) &&
          u.data.creator.contains(creatorId2),
    );
  }

  List<User> getUserByTwitchSubs(String twitchId1, String twitchId2) {
    return _getUserBy(
      (u) =>
          u.data.twitch.contains(twitchId1) &&
          u.data.twitch.contains(twitchId2),
    );
  }

  List<User> getUserByYoutubeSubs(String youtubeId1, String youtubeId2) {
    return _getUserBy(
      (u) =>
          u.data.youtube.contains(youtubeId1) &&
          u.data.youtube.contains(youtubeId2),
    );
  }

  List<User> getUserByChannelSubs(String twitchId, String youtubeId) {
    return _getUserBy(
      (u) =>
          u.data.twitch.contains(twitchId) &&
          u.data.youtube.contains(youtubeId),
    );
  }

  List<User> _getUserBy(bool filter(User user)) {
    return _user.where(filter).toList();
  }

  List<StatCount<Creator>> getCreatorStat(List<Creator> creator) {
    List<StatCount<Creator>> list = creator.map((c) {
      return StatCount(
        c,
        getUserByCreatorSub(c.creatorId).length / userCount,
      );
    }).toList();
    list.sort((a, b) => b.count.compareTo(a.count));
    return list;
  }

  List<StatCount<TwitchChannel>> getTwitchStat(List<TwitchChannel> channel) {
    List<StatCount<TwitchChannel>> list = channel.map((c) {
      return StatCount(
        c,
        getUserByTwitchSub(c.channelId).length / userCount,
      );
    }).toList();
    list.sort((a, b) => b.count.compareTo(a.count));
    return list;
  }

  List<StatCount<YoutubeChannel>> getYoutubeStat(List<YoutubeChannel> channel) {
    List<StatCount<YoutubeChannel>> list = channel.map((c) {
      return StatCount(
        c,
        getUserByYoutubeSub(c.channelId).length / userCount,
      );
    }).toList();
    list.sort((a, b) => b.count.compareTo(a.count));
    return list;
  }
}
