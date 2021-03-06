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

  YoutubeChannel.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    if (map.containsKey('youtubeId')) {
      youtubeId = map['youtubeId'] as String;
    }
    if (map.containsKey('updatedStatsAt')) {
      updatedStatsAt = getDate(map['updatedStatsAt']);
    }
    if (map.containsKey('snippet')) {
      if (map['snippet'] != null) {
        snippet = Snippet.fromMap(
          Map<String, dynamic>.from(map['snippet'] as Map),
        );
      }
    }
    if (map.containsKey('statistics')) {
      if (map['statistics'] != null) {
        statistics = Statistics.fromMap(
          Map<String, dynamic>.from(map['statistics'] as Map),
        );
      }
    }
    if (map.containsKey('brandingSettings')) {
      brandingSettings = BrandingSettings.fromMap(
        Map<String, dynamic>.from(map['brandingSettings'] as Map),
      );
    }
    if (map.containsKey('latestVideo')) {
      if (map['latestVideo'] != null) {
        latestVideo = Video.fromMap(
          Map<String, dynamic>.from(map['latestVideo'] as Map),
        );
      }
    }
  }

  Map<String, dynamic> toJson() => super.toJson()
    ..addAll(<String, dynamic>{
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
      commentCount = map['commentCount'] as int;
    }
    if (map.containsKey('hiddenSubscriberCount')) {
      hiddenSubscriberCount = map['hiddenSubscriberCount'] as bool;
    }
    if (map.containsKey('subscriberCount')) {
      subscriberCount = map['subscriberCount'] as int;
    }
    if (map.containsKey('videoCount')) {
      videoCount = map['videoCount'] as int;
    }
    if (map.containsKey('viewCount')) {
      viewCount = map['viewCount'] as int;
    }
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
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

  Snippet.fromMap(Map<String, dynamic> map) {
    if (map.containsKey('desc')) {
      this.desc = map['desc'] as String;
    }
    if (map.containsKey('publishedAt')) {
      this.publishedAt = getDate(map['publishedAt']);
    }
    if (map.containsKey('thumbnails')) {
      Map<String, dynamic> tmap =
          Map<String, dynamic>.from(map['thumbnails'] as Map);
      if (tmap != null) {
        this.defaultThumb = Thumb.fromMap(
          Map<String, dynamic>.from(tmap['default'] as Map),
        );
        this.mediumThumb = Thumb.fromMap(
          Map<String, dynamic>.from(tmap['medium'] as Map),
        );
        this.highThumb = Thumb.fromMap(
          Map<String, dynamic>.from(tmap['high'] as Map),
        );
      }
    }
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
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

  BrandingSettings.fromMap(Map<String, dynamic> map) {
    if (map.containsKey('image')) {
      bImage = BImage.fromMap(Map<String, dynamic>.from(map['image'] as Map));
    }
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
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

  BImage.fromMap(Map<String, dynamic> map) {
    if (map.containsKey('bannerImageUrl')) {
      bannerImageUrl = map['bannerImageUrl'] as String;
    }

    if (map.containsKey('bannerMobileExtraHdImageUrl')) {
      bannerMobileExtraHdImageUrl =
          map['bannerMobileExtraHdImageUrl'] as String;
    }
    if (map.containsKey('bannerMobileHdImageUrl')) {
      bannerMobileHdImageUrl = map['bannerMobileHdImageUrl'] as String;
    }
    if (map.containsKey('bannerMobileImageUrl')) {
      bannerMobileImageUrl = map['bannerMobileImageUrl'] as String;
    }
    if (map.containsKey('bannerMobileLowImageUrl')) {
      bannerMobileLowImageUrl = map['bannerMobileLowImageUrl'] as String;
    }
    if (map.containsKey('bannerMobileMediumHdImageUrl')) {
      bannerMobileMediumHdImageUrl =
          map['bannerMobileMediumHdImageUrl'] as String;
    }

    if (map.containsKey('bannerTabletExtraHdImageUrl')) {
      bannerTabletExtraHdImageUrl =
          map['bannerTabletExtraHdImageUrl'] as String;
    }
    if (map.containsKey('bannerTabletHdImageUrl')) {
      bannerTabletHdImageUrl = map['bannerTabletHdImageUrl'] as String;
    }
    if (map.containsKey('bannerTabletImageUrl')) {
      bannerTabletImageUrl = map['bannerTabletImageUrl'] as String;
    }
    if (map.containsKey('bannerTabletLowImageUrl')) {
      bannerTabletLowImageUrl = map['bannerTabletLowImageUrl'] as String;
    }

    if (map.containsKey('bannerTvHighImageUrl')) {
      bannerImageUrl = map['bannerTvHighImageUrl'] as String;
    }
    if (map.containsKey('bannerTvImageUrl')) {
      bannerTvImageUrl = map['bannerTvImageUrl'] as String;
    }
    if (map.containsKey('bannerTvLowImageUrl')) {
      bannerTvLowImageUrl = map['bannerTvLowImageUrl'] as String;
    }
    if (map.containsKey('bannerTvMediumImageUrl')) {
      bannerTvMediumImageUrl = map['bannerTvMediumImageUrl'] as String;
    }

    if (map.containsKey('trackingImageUrl')) {
      trackingImageUrl = map['trackingImageUrl'] as String;
    }
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
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
    videoId = map['id']['videoId'] as String;
    youtubeId = map['snippet']['channelId'] as String;
    title = map['snippet']['title'] as String;
    desc = map['snippet']['description'] as String;
    publishedAt = getDate(map['snippet']['publishedAt']);
    defaultThumb = Thumb.fromMap(
      Map<String, dynamic>.from(map['snippet']['thumbnails']['default'] as Map),
    );
    mediumThumb = Thumb.fromMap(
      Map<String, dynamic>.from(map['snippet']['thumbnails']['medium'] as Map),
    );
    highThumb = Thumb.fromMap(
      Map<String, dynamic>.from(map['snippet']['thumbnails']['high'] as Map),
    );
    maxresThumb = Thumb.fromMap(
      Map<String, dynamic>.from(
          map['snippet']['thumbnails']['maxresThumb'] as Map),
    );
    standardThumb = Thumb.fromMap(
      Map<String, dynamic>.from(
          map['snippet']['thumbnails']['standardThumb'] as Map),
    );
  }

  Video.fromMap(Map<String, dynamic> map) {
    this.youtubeId = map['youtubeId'] as String;
    this.videoId = map['videoId'] as String;
    this.title = map['title'] as String;
    this.desc = map['desc'] as String;
    this.publishedAt =
        DateTime.fromMillisecondsSinceEpoch(map['publishedAt'] as int);
    duration = parseTime(map['duration'] as String);

    if (map.containsKey('thumbnails')) {
      Map<String, dynamic> tmap =
          Map<String, dynamic>.from(map['thumbnails'] as Map);
      if (tmap.containsKey('default')) {
        this.defaultThumb = Thumb.fromMap(
          Map<String, dynamic>.from(tmap['default'] as Map),
        );
      }
      if (tmap.containsKey('high')) {
        this.highThumb = Thumb.fromMap(
          Map<String, dynamic>.from(tmap['high'] as Map),
        );
      }
      if (tmap.containsKey('maxres')) {
        this.maxresThumb = Thumb.fromMap(
          Map<String, dynamic>.from(tmap['maxres'] as Map),
        );
      }
      if (tmap.containsKey('medium')) {
        this.mediumThumb = Thumb.fromMap(
          Map<String, dynamic>.from(tmap['medium'] as Map),
        );
      }
      if (tmap.containsKey('standard')) {
        this.standardThumb = Thumb.fromMap(
          Map<String, dynamic>.from(tmap['standard'] as Map),
        );
      }
    }
    if (map.containsKey('creator')) {
      creator =
          (map['creator'] as List).map((dynamic e) => e as String).map((id) {
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

  Map<String, dynamic> toJson() => <String, dynamic>{
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
        url = map['url'] as String;
      }
      if (map.containsKey('height')) {
        height = map['height'] as int;
      }
      if (map.containsKey('width')) {
        width = map['width'] as int;
      }
    }
  }

  @override
  String toString() {
    // TODO: implement toString
    return {url: url, height: height, width: width}.toString();
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'url': url, 'height': height, 'width': width};
}
