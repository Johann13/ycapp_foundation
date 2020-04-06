import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ycapp_foundation/model/channel/twitch_channel.dart';
import 'package:ycapp_foundation/ui/loader/base/y_builder.dart';
import 'package:ycapp_foundation/ui/loader/base/y_stream_widgets.dart';

class TwitchStreamBuilder extends YStreamBuilder<TwitchChannel> {
  TwitchStreamBuilder({
    @required Stream<TwitchChannel> channel,
    @required YDataBuilder<TwitchChannel> builder,
    ErrorBuilder error,
    WidgetBuilder loading,
  }) : super(
          stream: channel,
          error: error,
          loading: loading,
          builder: builder,
        );
}

class TwitchListStream extends YStreamListBuilder<TwitchChannel> {
  TwitchListStream({
    @required Stream<List<TwitchChannel>> channel,
    @required YDataBuilder<List<TwitchChannel>> builder,
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

class TwitchVideoListStream extends YStreamListBuilder<TwitchVideo> {
  TwitchVideoListStream({
    @required Stream<List<TwitchVideo>> videos,
    @required YDataBuilder<List<TwitchVideo>> builder,
    ErrorBuilder error,
    WidgetBuilder empty,
    WidgetBuilder loading,
  }) : super(
          stream: videos,
          error: error,
          empty: empty,
          loading: loading,
          builder: builder,
        );
}

class TwitchClipListStream extends YStreamListBuilder<TwitchClip> {
  TwitchClipListStream({
    @required Stream<List<TwitchClip>> clips,
    @required YDataBuilder<List<TwitchClip>> builder,
    ErrorBuilder error,
    WidgetBuilder empty,
    WidgetBuilder loading,
  }) : super(
          stream: clips,
          error: error,
          empty: empty,
          loading: loading,
          builder: builder,
        );
}
