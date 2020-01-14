import 'package:ycapp_foundation/model/channel/channel.dart';
import 'package:ycapp_foundation/model/channel/image_quality.dart';
import 'package:ycapp_foundation/model/date_util.dart';

class YoutubeChannel extends Channel {
  String youtubeId;
  Snippet snippet;
  Statistics statistics;
  BrandingSettings brandingSettings;
  DateTime updatedStatsAt;
  Video latestVideo;

  YoutubeChannel.fromMap(Map map) : super.fromMap(map) {
    if (map.containsKey('youtubeId')) {
      youtubeId = map['youtubeId'];
    }
    if (map.containsKey('updatedStatsAt')) {
      updatedStatsAt = getDate(map['updatedStatsAt']);
    }
    if (map.containsKey('snippet')) {
      if (map['snippet'] != null) {
        snippet = Snippet.fromMap(map['snippet']);
      }
    }
    if (map.containsKey('statistics')) {
      if (map['statistics'] != null) {
        statistics = Statistics.fromMap(map['statistics']);
      }
    }
    if (map.containsKey('brandingSettings')) {
      brandingSettings = BrandingSettings.fromMap(map['brandingSettings']);
    }
    if (map.containsKey('latestVideo')) {
      if (map['latestVideo'] != null) {
        latestVideo = Video.fromMap(map['latestVideo']);
      }
    }
  }

  Map toJson() => super.toJson()
    ..addAll({
      'youtubeId': youtubeId,
      'snippet': snippet.toJson(),
      'statistics': statistics.toJson(),
      'brandingSettings': brandingSettings.toJson(),
      'updatedStatsAt': updatedStatsAt?.millisecondsSinceEpoch,
      'latestVideo': latestVideo?.toJson(),
    });
}

class Statistics {
  int commentCount;
  bool hiddenSubscriberCount;
  int subscriberCount;
  int videoCount;
  int viewCount;

  Statistics.fromMap(Map<dynamic, dynamic> map) : assert(map != null) {
    if (map.containsKey('commentCount')) {
      commentCount = map['commentCount'];
    }
    if (map.containsKey('hiddenSubscriberCount')) {
      hiddenSubscriberCount = map['hiddenSubscriberCount'];
    }
    if (map.containsKey('subscriberCount')) {
      subscriberCount = map['subscriberCount'];
    }
    if (map.containsKey('videoCount')) {
      videoCount = map['videoCount'];
    }
    if (map.containsKey('viewCount')) {
      viewCount = map['viewCount'];
    }
  }

  Map toJson() => {
        'commentCount': commentCount,
        'hiddenSubscriberCount': hiddenSubscriberCount,
        'subscriberCount': subscriberCount,
        'videoCount': videoCount,
        'viewCount': viewCount,
      };
}

class Snippet {
  String desc;
  DateTime publishedAt;

  Thumb defaultThumb;
  Thumb mediumThumb;
  Thumb highThumb;

  Snippet.fromMap(Map map) {
    if (map.containsKey('desc')) {
      this.desc = map['desc'];
    }
    if (map.containsKey('publishedAt')) {
      this.publishedAt = getDate(map['publishedAt']);
    }
    if (map.containsKey('thumbnails')) {
      Map tmap = map['thumbnails'];
      if (tmap != null) {
        this.defaultThumb = Thumb.fromMap(tmap['default']);
        this.mediumThumb = Thumb.fromMap(tmap['medium']);
        this.highThumb = Thumb.fromMap(tmap['high']);
      }
    }
  }

  Map toJson() => {
        'desc': desc,
        'thumbnails': {
          'default': defaultThumb.toJson(),
          'medium': mediumThumb.toJson(),
          'high': highThumb.toJson(),
        },
      };
}

class BrandingSettings {
  BImage bImage;

  BrandingSettings.fromMap(Map map) {
    if (map.containsKey('image')) {
      bImage = BImage.fromMap(map['image']);
    }
  }

  Map toJson() => {
        'image': bImage.toJson(),
      };
}

class BImage {
  String bannerImageUrl;

  String bannerMobileExtraHdImageUrl;
  String bannerMobileHdImageUrl;
  String bannerMobileImageUrl;
  String bannerMobileLowImageUrl;
  String bannerMobileMediumHdImageUrl;

  String bannerTabletExtraHdImageUrl;
  String bannerTabletHdImageUrl;
  String bannerTabletImageUrl;
  String bannerTabletLowImageUrl;

  String bannerTvHighImageUrl;
  String bannerTvImageUrl;
  String bannerTvLowImageUrl;
  String bannerTvMediumImageUrl;

  String trackingImageUrl;

  BImage.fromMap(Map map) {
    if (map.containsKey('bannerImageUrl')) {
      bannerImageUrl = map['bannerImageUrl'];
    }

    if (map.containsKey('bannerMobileExtraHdImageUrl')) {
      bannerMobileExtraHdImageUrl = map['bannerMobileExtraHdImageUrl'];
    }
    if (map.containsKey('bannerMobileHdImageUrl')) {
      bannerMobileHdImageUrl = map['bannerMobileHdImageUrl'];
    }
    if (map.containsKey('bannerMobileImageUrl')) {
      bannerMobileImageUrl = map['bannerMobileImageUrl'];
    }
    if (map.containsKey('bannerMobileLowImageUrl')) {
      bannerMobileLowImageUrl = map['bannerMobileLowImageUrl'];
    }
    if (map.containsKey('bannerMobileMediumHdImageUrl')) {
      bannerMobileMediumHdImageUrl = map['bannerMobileMediumHdImageUrl'];
    }

    if (map.containsKey('bannerTabletExtraHdImageUrl')) {
      bannerTabletExtraHdImageUrl = map['bannerTabletExtraHdImageUrl'];
    }
    if (map.containsKey('bannerTabletHdImageUrl')) {
      bannerTabletHdImageUrl = map['bannerTabletHdImageUrl'];
    }
    if (map.containsKey('bannerTabletImageUrl')) {
      bannerTabletImageUrl = map['bannerTabletImageUrl'];
    }
    if (map.containsKey('bannerTabletLowImageUrl')) {
      bannerTabletLowImageUrl = map['bannerTabletLowImageUrl'];
    }

    if (map.containsKey('bannerTvHighImageUrl')) {
      bannerImageUrl = map['bannerTvHighImageUrl'];
    }
    if (map.containsKey('bannerTvImageUrl')) {
      bannerTvImageUrl = map['bannerTvImageUrl'];
    }
    if (map.containsKey('bannerTvLowImageUrl')) {
      bannerTvLowImageUrl = map['bannerTvLowImageUrl'];
    }
    if (map.containsKey('bannerTvMediumImageUrl')) {
      bannerTvMediumImageUrl = map['bannerTvMediumImageUrl'];
    }

    if (map.containsKey('trackingImageUrl')) {
      trackingImageUrl = map['trackingImageUrl'];
    }
  }

  Map toJson() => {
        'bannerMobileExtraHdImageUrl': bannerMobileExtraHdImageUrl,
        'bannerMobileHdImageUrl': bannerMobileHdImageUrl,
        'bannerMobileImageUrl': bannerMobileImageUrl,
        'bannerMobileLowImageUrl': bannerMobileLowImageUrl,
        'bannerMobileMediumHdImageUrl': bannerMobileMediumHdImageUrl,
        'bannerTabletExtraHdImageUrl': bannerTabletExtraHdImageUrl,
        'bannerTabletHdImageUrl': bannerTabletHdImageUrl,
        'bannerTabletImageUrl': bannerTabletImageUrl,
        'bannerTabletLowImageUrl': bannerTabletLowImageUrl,
        'bannerTvHighImageUrl': bannerTvHighImageUrl,
        'bannerTvImageUrl': bannerTvImageUrl,
        'bannerTvLowImageUrl': bannerTvLowImageUrl,
        'bannerTvMediumImageUrl': bannerTvMediumImageUrl,
        'trackingImageUrl': trackingImageUrl,
      };
}

class Video {
  String youtubeId;
  String videoId;
  String title;
  String desc;
  DateTime publishedAt;

  //region thumbs
  //120x90
  Thumb defaultThumb;

  //320x180
  Thumb mediumThumb;

  //480x360
  Thumb highThumb;

  //640x480
  Thumb standardThumb;

  //1280x720
  Thumb maxresThumb;

  //endregion

  Thumb get xl => maxresThumb;

  Thumb get l => standardThumb;

  Thumb get m => highThumb;

  Thumb get s => mediumThumb;

  Thumb get xs => defaultThumb;

  String duration;
  List<String> creator;

  //Use only if you call the youtube api directly
  Video.fromJson(Map<String, dynamic> map) {
    videoId = map['id']['videoId'];
    youtubeId = map['snippet']['channelId'];
    title = map['snippet']['title'];
    desc = map['snippet']['description'];
    publishedAt = getDate(map['snippet']['publishedAt']);
    defaultThumb = Thumb.fromMap(map['snippet']['thumbnails']['default']);
    mediumThumb = Thumb.fromMap(map['snippet']['thumbnails']['medium']);
    highThumb = Thumb.fromMap(map['snippet']['thumbnails']['high']);
    maxresThumb = Thumb.fromMap(map['snippet']['thumbnails']['maxresThumb']);
    standardThumb =
        Thumb.fromMap(map['snippet']['thumbnails']['standardThumb']);
  }

  Video.fromMap(Map<dynamic, dynamic> map) {
    this.youtubeId = map['youtubeId'];
    this.videoId = map['videoId'];
    this.title = map['title'];
    this.desc = map['desc'];
    this.publishedAt = DateTime.fromMillisecondsSinceEpoch(map['publishedAt']);
    duration = parseTime(map['duration']);

    if (map.containsKey('thumbnails')) {
      Map tmap = map['thumbnails'];
      if (tmap.containsKey('default')) {
        this.defaultThumb = Thumb.fromMap(tmap['default']);
      }
      if (tmap.containsKey('high')) {
        this.highThumb = Thumb.fromMap(tmap['high']);
      }
      if (tmap.containsKey('maxres')) {
        this.maxresThumb = Thumb.fromMap(tmap['maxres']);
      }
      if (tmap.containsKey('medium')) {
        this.mediumThumb = Thumb.fromMap(tmap['medium']);
      }
      if (tmap.containsKey('standard')) {
        this.standardThumb = Thumb.fromMap(tmap['standard']);
      }
    }
    if (map.containsKey('creator')) {
      creator = (map['creator'] as List).cast<String>().map((id) {
        if (id.startsWith('-')) {
          return id;
        } else {
          return '-$id';
        }
      }).toList();
    } else {
      creator = [];
    }
  }

  Thumb getThumb(YoutubeQuality quality, bool useSmallImage) {
    if (useSmallImage) {
      switch (quality) {
        case YoutubeQuality.high:
        case YoutubeQuality.medium:
          return s;
          break;
        case YoutubeQuality.low:
        default:
          return xs;
          break;
      }
    } else {
      switch (quality) {
        case YoutubeQuality.high:
          return l;
          break;
        case YoutubeQuality.medium:
          return m;
          break;
        case YoutubeQuality.low:
        default:
          return xs;
          break;
      }
    }
  }

  String get videoUrl {
    if (mediumThumb != null) {
      return mediumThumb.url;
    } else if (defaultThumb != null) {
      return defaultThumb.url;
    }
    return null;
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
    bool hasH = time.contains('H');
    bool hasM = time.contains('M');
    bool hasS = time.contains('S');
    time = time.replaceFirst('PT', '');

    String h = '';
    String m = '';
    String s = '';
    String r = '';
    if (hasH) {
      List<String> split = time.split('H');
      h = twoDigits(int.tryParse(split[0]));
      time = split[1];
      r = h;
    }
    if (hasM) {
      List<String> split = time.split('M');
      m = twoDigits(int.tryParse(split[0]));
      time = split[1];

      if (hasH) {
        r = r + ':$m';
      } else {
        r = m;
      }
    }
    if (hasS) {
      List<String> split = time.split('S');
      s = twoDigits(int.tryParse(split[0]));
      time = split[1];
      if (hasM || hasH) {
        r = r + ':$s';
      } else {
        r = s;
      }
    } else {
      r = r + ':00';
    }

    return r;
  }

  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  @override
  String toString() {
    return {
      youtubeId: youtubeId,
      videoId: videoId,
      title: title,
      defaultThumb: defaultThumb,
    }.toString();
  }

  Map toJson() => {
        'youtubeId': youtubeId,
        'videoId': videoId,
        'title': title,
        'desc': desc,
        'publishedAt': publishedAt?.millisecondsSinceEpoch,
        'duration': duration,
        'creator': creator,
      };
}

class Thumb {
  String url;
  int height;
  int width;

  Thumb.fromMap(Map<dynamic, dynamic> map) {
    if (map != null) {
      if (map.containsKey('url')) {
        url = map['url'];
      }
      if (map.containsKey('height')) {
        height = map['height'];
      }
      if (map.containsKey('width')) {
        width = map['width'];
      }
    }
  }

  @override
  String toString() {
    // TODO: implement toString
    return {url: url, height: height, width: width}.toString();
  }

  Map toJson() => {'url': url, 'height': height, 'width': width};
}
