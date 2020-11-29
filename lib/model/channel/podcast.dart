import 'package:http/http.dart' as http;
import 'package:webfeed/domain/rss_feed.dart';
import 'package:ycapp_foundation/model/channel/channel.dart';

class Podcast extends Channel {
  RssFeed rssFeed;

  Podcast.fromMap(Map<String, dynamic> map) : super.fromMap(map);

  Future<void> loadRssFeed() async {
    this.rssFeed = await _feed;
  }

  Future<RssFeed> get _feed {
    return http.get(url).then((resp) => RssFeed.parse(resp.body));
  }
}
