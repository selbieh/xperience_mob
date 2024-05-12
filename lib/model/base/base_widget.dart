// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum WidgetType { normalBuild, staticBuild, consume }

class BaseWidget<T extends ChangeNotifier> extends StatefulWidget {
  final T? model;
  final Widget? staticChild;
  final WidgetType? type;
  final Function(T)? initState;
  final Function(T)? dispose;
  final Widget Function(BuildContext context, T model, Widget? child) builder;
  final Widget Function(BuildContext context, T model)? staticBuilder;

  const BaseWidget({
    Key? key,
    this.model,
    this.initState,
    this.dispose,
    this.staticBuilder,
    required this.builder,
  })  : staticChild = null,
        type = WidgetType.normalBuild;

  const BaseWidget.staticBuilder({
    this.model,
    this.initState,
    this.dispose,
    this.staticBuilder,
    required this.builder,
  })  : type = WidgetType.staticBuild,
        staticChild = null;

  const BaseWidget.cosnume({required this.builder})
      : type = WidgetType.consume,
        model = null,
        staticChild = null,
        initState = null,
        dispose = null,
        staticBuilder = null;
  @override
  BaseWidgetState<T> createState() => BaseWidgetState<T>();
}

class BaseWidgetState<T extends ChangeNotifier> extends State<BaseWidget<T>> {
  T? model;
  @override
  void initState() {
    model = widget.model;
    if (widget.initState != null) {
      widget.initState!(model!);
    }
    super.initState();
  }

  @override
  void dispose() {
    model = widget.model;
    if (widget.dispose != null) {
      widget.dispose!(model!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == WidgetType.consume) {
      return Consumer<T>(builder: widget.builder);
    } else {
      return ChangeNotifierProvider<T>(
        create: (context) => model!,
        child: widget.type == WidgetType.staticBuild
            ? widget.staticBuilder!(context, model!)
            : Consumer<T>(builder: widget.builder, child: widget.staticChild),
      );
    }
  }
}
