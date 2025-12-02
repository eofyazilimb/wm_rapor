import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'wm_rapor_method_channel.dart';

abstract class WmRaporPlatform extends PlatformInterface {
  /// Constructs a WmRaporPlatform.
  WmRaporPlatform() : super(token: _token);

  static final Object _token = Object();

  static WmRaporPlatform _instance = MethodChannelWmRapor();

  /// The default instance of [WmRaporPlatform] to use.
  ///
  /// Defaults to [MethodChannelWmRapor].
  static WmRaporPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WmRaporPlatform] when
  /// they register themselves.
  static set instance(WmRaporPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
