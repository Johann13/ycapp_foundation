import 'package:ycapp_foundation/model/channel/twitch_channel.dart';
import 'package:ycapp_foundation/model/channel/youtube_channel.dart';
import 'package:ycapp_foundation/model/creator/creator.dart';

class YSort {
  static int sortTwitchChannelByLastLive(TwitchChannel a, TwitchChannel b) {
    if (a.isLive && b.isLive) {
      if (a.isCinema) {
        return 1;
      } else if (b.isCinema) {
        return -1;
      } else {
        return b.stream.viewerCount.compareTo(a.stream.viewerCount);
      }
    } else if (a.isLive && !b.isLive) {
      return -1;
    } else if (!a.isLive && b.isLive) {
      return 1;
    } else if (a.hasPrevStream && b.hasPrevStream) {
      return b.prevStream.endedAt.compareTo(a.prevStream.endedAt);
    } else if (a.hasPrevStream && !b.hasPrevStream) {
      return -1;
    } else if (!a.hasPrevStream && b.hasPrevStream) {
      return 1;
    } else {
      return a.name.toUpperCase().compareTo(b.name.toUpperCase());
    }
  }

  static int sortTwitchChannelByName(TwitchChannel a, TwitchChannel b) =>
      a.name.toUpperCase().compareTo(b.name.toUpperCase());

  static int sortYoutubeChannelByLastUpload(
      YoutubeChannel a, YoutubeChannel b) {
    if (a.latestVideo != null && b.latestVideo != null) {
      return b.latestVideo.publishedAt.compareTo(a.latestVideo.publishedAt);
    } else if (a.latestVideo == null && b.latestVideo == null) {
      return a.name.compareTo(b.name);
    } else if (a.latestVideo != null) {
      return -1;
    } else if (b.latestVideo != null) {
      return 1;
    }
    return 0;
  }

  static int sortYoutubeChannelByName(YoutubeChannel a, YoutubeChannel b) =>
      a.name.toUpperCase().compareTo(b.name.toUpperCase());

  static int sortCreatorByName(Creator a, Creator b) =>
      a.name.toUpperCase().compareTo(b.realName.toUpperCase());


  static int sortCreatorByLastLive(Creator a, Creator b){
    if (a.lastLive != null && b.lastLive != null) {
      return b.lastLive.compareTo(a.lastLive);
    } else if (a.lastLive != null) {
      return -1;
    } else if (b.lastLive != null) {
      return 1;
    }
    return a.name.compareTo(b.name);
  }
}
