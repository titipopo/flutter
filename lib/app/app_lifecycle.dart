// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:developer';

import 'package:flutter/widgets.dart';

class AppLifecycleObserver extends StatefulWidget {
  const AppLifecycleObserver({required this.child, super.key});

  final Widget child;

  @override
  State<AppLifecycleObserver> createState() => AppLifecycleObserverState();
}

@visibleForTesting
class AppLifecycleObserverState extends State<AppLifecycleObserver>
    with WidgetsBindingObserver {
  final ValueNotifier<AppLifecycleState> lifecycleListenable =
      ValueNotifier(AppLifecycleState.inactive);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AppLifecycleState>(
        valueListenable: lifecycleListenable,
        builder:
            (BuildContext context, AppLifecycleState value, Widget? child) {
          return widget.child;
        });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log('didChangeAppLifecycleState: $state');
    lifecycleListenable.value = state;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    log('Subscribed to app lifecycle updates');
  }
}
