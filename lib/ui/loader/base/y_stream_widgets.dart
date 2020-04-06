import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ycapp_foundation/ui/loader/base/y_builder.dart';

class YStreamBuilder<T> extends StreamBuilder<T> {
  YStreamBuilder({
    @required Stream<T> stream,
    @required YDataBuilder<T> builder,
    ErrorBuilder error,
    WidgetBuilder loading,
    T initialData,
  }) : super(
          initialData: initialData,
          stream: stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              if (error == null) {
                return Center(
                  child: Text(
                    'an error occurred ' + snapshot.error.toString(),
                  ),
                );
              } else {
                return error(context, snapshot.error);
              }
            }
            if (!snapshot.hasData) {
              if (loading == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return loading(context);
              }
            }
            return builder(context, snapshot.data);
          },
        );
}

class YStreamListBuilder<T> extends StreamBuilder<List<T>> {
  YStreamListBuilder({
    @required Stream<List<T>> stream,
    @required YDataBuilder<List<T>> builder,
    List<T> initialData,
    ErrorBuilder error,
    WidgetBuilder loading,
    WidgetBuilder empty,
  }) : super(
          //initialData: initialData != null ? initialData : [],
          stream: stream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              if (error == null) {
                print(snapshot.error);
                return Center(
                  child: Text(
                    'an error occurred:\n' + snapshot.error.toString(),
                  ),
                );
              } else {
                return error(context, snapshot.error);
              }
            }
            if (!snapshot.hasData) {
              if (loading == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return loading(context);
              }
            }
            if (snapshot.data.isEmpty) {
              if (empty == null) {
                return Center(
                  child: Text('No data found'),
                );
              } else {
                return empty(context);
              }
            }
            return builder(context, snapshot.data);
          },
        );
}
