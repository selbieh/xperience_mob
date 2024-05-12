import 'package:flutter/material.dart';

/*
 * add mounted option to stop calling build methods after disposal
 */

enum NotifierState { busy, idle, hasError }

class BaseNotifier extends ChangeNotifier {
  NotifierState _state = NotifierState.idle;
  bool _mounted = true;

  BaseNotifier({NotifierState? state}) {
    if (state != null) _state = state;
  }

  NotifierState get state => _state;
  bool get mounted => _mounted;
  bool get idle => _state == NotifierState.idle;
  bool get isBusy => _state == NotifierState.busy;
  bool get hasError => _state == NotifierState.hasError;

  setBusy() => setState(state: NotifierState.busy);
  setIdle() => setState(state: NotifierState.idle);
  setError() => setState(state: NotifierState.hasError);

  String? failure;

  setState({NotifierState? state, bool notifierListener = true}) {
    if (state != null) _state = state;
    if (mounted && notifierListener) notifyListeners();
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
