import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

enum Sort {
  New,
  Top,
}

enum SortTime {
  Day,
  Week,
  Month,
}

class RedditPosts {
  final List<Post> posts;

  RedditPosts(this.posts);

  static Future<RedditPosts> getTop(
    String subreddit, {
    int limit = 10,
    SortTime time = SortTime.Week,
  }) =>
      get(subreddit, sort: Sort.Top, time: time);

  static Future<RedditPosts> getNew(
    String subreddit, {
    int limit = 10,
  }) =>
      get(subreddit, sort: Sort.New);

  static Future<RedditPosts> get(
    String subreddit, {
    int limit = 10,
    Sort sort = Sort.Top,
    SortTime time = SortTime.Week,
  }) async {
    String url = 'https://www.reddit.com/r/$subreddit';
    switch (sort) {
      case Sort.New:
        url += '/new/.json?limit=$limit';
        break;
      case Sort.Top:
        switch (time) {
          case SortTime.Day:
            url += '/top/.json?limit=$limit&t=day';
            break;
          case SortTime.Week:
            url += '/top/.json?limit=$limit&t=week';
            break;
          case SortTime.Month:
            url += '/top/.json?limit=$limit&t=month';
            break;
        }
        break;
    }
    return _get(url);
  }

  static Future<RedditPosts> _get(String url) async {
    http.Response resp = await http.get(url);

    String body = resp.body;
    Map<String, dynamic> json =
        convert.json.decode(body) as Map<String, dynamic>;
    List<Map<String, dynamic>> children =
        json['data']['children'] as List<Map<String, dynamic>>;
    List<Post> posts = children
        .map((e) => Post.fromMap(e['data'] as Map<String, dynamic>))
        .toList();
    return RedditPosts(posts);
  }
}

class Post {
  final String title;
  final String markdown;
  final String html;
  final String url;

  Post(
    this.title,
    this.markdown,
    this.html,
    this.url,
  );

  Post.fromMap(Map<String, dynamic> map)
      : this(
          map['title'] as String,
          map['selftext'] as String,
          (map['selftext_html'] as String)
                  ?.replaceAll("<!-- SC_OFF -->", '')
                  ?.replaceAll("<!-- SC_ON -->", '')
                  ?.replaceAll("&lt;!-- SC_OFF --&gt;", '')
                  ?.replaceAll(";&lt;!-- SC_ON --&gt", '') ??
              '',
          map['url'] as String,
        );
}
