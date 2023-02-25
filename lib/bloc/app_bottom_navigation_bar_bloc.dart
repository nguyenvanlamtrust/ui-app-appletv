import 'dart:async';

import 'package:flutter/material.dart';

class AppBottomNavigationBarBloc {

  int initTabIndex = 0;
  int _tabIndex = 0;

  final PageController pageViewController = PageController();

  final StreamController<int> _streamController = StreamController<int>.broadcast();
  Stream<int> get stream => _streamController.stream;

  void changeTabIndex(int newVal) {
    _tabIndex = newVal;
    _streamController.sink.add(_tabIndex);
    pageViewController.jumpToPage(_tabIndex);
  }

  void dispose() {
    _streamController.close();
  }

}