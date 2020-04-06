import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ycapp_foundation/ui/loader/base/y_builder.dart';

class YFutureBuilder<T> extends FutureBuilder<T> {
  YFutureBuilder({
    @required Future<T> future,
    @required YDataBuilder<T> builder,
    ErrorBuilder error,
    WidgetBuilder loading,
    T initialData,
  }) : super(
          initialData: initialData,
          future: future,
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

class YFutureListBuilder<T> extends FutureBuilder<List<T>> {
  final ErrorBuilder errorBuilder;

  YFutureListBuilder({
    @required Future<List<T>> future,
    @required YDataBuilder<List<T>> builder,
    List<T> initialData,
    ErrorBuilder error,
    this.errorBuilder,
    WidgetBuilder loading,
    WidgetBuilder empty,
  }) : super(
          //initialData: initialData != null ? initialData : [],
          future: future,

          builder: (context, snapshot) {
            if (snapshot.hasError) {
              if (errorBuilder != null) {
                return errorBuilder(context, snapshot.error);
              } else if (error != null) {
                return error(context, snapshot.error);
              } else {
                print(snapshot.error);
                return Center(
                  child: Text(
                    'an error occurred:\n' + snapshot.error.toString(),
                  ),
                );
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
