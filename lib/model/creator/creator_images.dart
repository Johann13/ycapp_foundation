
class Images {
  TwitchImages twitchImages;
  YoutubeImages youtubeImages;

  Images(Map map) {
    this.twitchImages = TwitchImages(map['twitch']);
    this.youtubeImages = YoutubeImages(map['youtube']);
  }
  Map toJson() => {
    'twitch': twitchImages.toJson(),
    'youtube': youtubeImages.toJson(),
  };
}

class TwitchImages {
  String banner;
  String profile;

  TwitchImages(Map map) {
    this.banner = map['banner'];
    this.profile = map['profile'];
  }
  Map toJson() => {
    'banner': banner,
    'profile': profile,
  };
}

class YoutubeImages {
  YoutubeImage banner;
  YoutubeImage profile;

  YoutubeImages(Map map) {
    this.banner = YoutubeImage(map['banner']);
    this.profile = YoutubeImage(map['profile']);
  }
  Map toJson() => {
    'banner': banner.toJson(),
    'profile': profile.toJson(),
  };
}

class YoutubeImage {
  String low;
  String medium;
  String high;

  YoutubeImage(Map map) {
    this.low = map['low'];
    this.medium = map['medium'];
    this.high = map['high'];
  }
  Map toJson() => {
    'low': low,
    'medium': medium,
    'high': high,
  };
}
