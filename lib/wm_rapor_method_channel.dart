import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'wm_rapor_platform_interface.dart';

/// An implementation of [WmRaporPlatform] that uses method channels.
class MethodChannelWmRapor extends WmRaporPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('wm_rapor');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
