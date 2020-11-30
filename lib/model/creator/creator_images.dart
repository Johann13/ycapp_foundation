class Images {
  TwitchImages twitchImages;
  YoutubeImages youtubeImages;

  Images(Map<String, dynamic> map) {
    this.twitchImages = TwitchImages(
      Map<String, dynamic>.from(map['twitch'] as Map),
    );
    this.youtubeImages = YoutubeImages(
      Map<String, dynamic>.from(map['youtube'] as Map),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'twitch': twitchImages.toJson(),
        'youtube': youtubeImages.toJson(),
      };
}

class TwitchImages {
  String banner;
  String profile;

  TwitchImages(Map<String, dynamic> map) {
    this.banner = map['banner'] as String;
    this.profile = map['profile'] as String;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'banner': banner,
        'profile': profile,
      };
}

class YoutubeImages {
  YoutubeImage banner;
  YoutubeImage profile;

  YoutubeImages(Map<String, dynamic> map) {
    this.banner = YoutubeImage(
      Map<String, dynamic>.from(map['banner'] as Map),
    );
    this.profile = YoutubeImage(
      Map<String, dynamic>.from(map['profile'] as Map),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'banner': banner.toJson(),
        'profile': profile.toJson(),
      };
}

class YoutubeImage {
  String low;
  String medium;
  String high;

  YoutubeImage(Map<String, dynamic> map) {
    this.low = map['low'] as String;
    this.medium = map['medium'] as String;
    this.high = map['high'] as String;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'low': low,
        'medium': medium,
        'high': high,
      };
}
