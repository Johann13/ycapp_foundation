import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ycapp_foundation/model/channel/youtube_channel.dart';
import 'package:ycapp_foundation/ui/loader/base/y_builder.dart';
import 'package:ycapp_foundation/ui/loader/base/y_stream_widgets.dart';

class YoutubeStream extends YStreamBuilder<YoutubeChannel> {
  YoutubeStream({
    @required Stream<YoutubeChannel> channel,
    @required YDataBuilder<YoutubeChannel> builder,
    ErrorBuilder error,
    WidgetBuilder loading,
  }) : super(
          stream: channel,
          error: error,
          loading: loading,
          builder: builder,
        );
}

class YoutubeListStream extends YStreamListBuilder<YoutubeChannel> {
  YoutubeListStream({
    @required Stream<List<YoutubeChannel>> channel,
    @required YDataBuilder<List<YoutubeChannel>> builder,
    ErrorBuilder error,
    WidgetBuilder empty,
    WidgetBuilder loading,
  }) : super(
          stream: channel,
          error: error,
          empty: empty,
          loading: loading,
          builder: builder,
        );
}

class YoutubeVideoListStream extends YStreamListBuilder<Video> {
  YoutubeVideoListStream({
    @required Stream<List<Video>> channel,
    @required YDataBuilder<List<Video>> builder,
    ErrorBuilder error,
    WidgetBuilder empty,
    WidgetBuilder loading,
  }) : super(
          stream: channel,
          error: error,
          empty: empty,
          loading: loading,
          builder: builder,
        );
}
