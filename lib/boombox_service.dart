import 'dart:async';

import 'package:flutter/services.dart';

class BoomboxService {
  static const _volumeChannel = EventChannel("boombox/volume_stream");

  static StreamSubscription<int>? _subscription;

  static void startListening(Function(int) onVolumeChanged) {
    _subscription = _volumeChannel
        .receiveBroadcastStream()
        .map((event) => event as int)
        .listen(onVolumeChanged);
  }

  static void stopListening() {
    _subscription?.cancel();
    _subscription = null;
  }
}
