import 'package:flutter/widgets.dart';
import 'package:ycapp_foundation/model/creator/creator.dart';
import 'package:ycapp_foundation/ui/loader/base/y_builder.dart';
import 'package:ycapp_foundation/ui/loader/base/y_stream_widgets.dart';

class CreatorStream extends YStreamBuilder<Creator> {
  CreatorStream({
    @required Stream<Creator> creator,
    @required YDataBuilder<Creator> builder,
    ErrorBuilder error,
    WidgetBuilder loading,
  }) : super(
          stream: creator,
          error: error,
          loading: loading,
          builder: builder,
        );
}

class CreatorListStream extends YStreamListBuilder<Creator> {
  CreatorListStream({
    @required Stream<List<Creator>> creator,
    @required YDataBuilder<List<Creator>> builder,
    ErrorBuilder error,
    WidgetBuilder empty,
    WidgetBuilder loading,
  }) : super(
          stream: creator,
          error: error,
          empty: empty,
          loading: loading,
          builder: builder,
        );
}
