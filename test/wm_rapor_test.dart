import 'package:flutter_test/flutter_test.dart';
import 'package:wm_rapor/wm_rapor.dart';
import 'package:wm_rapor/wm_rapor_platform_interface.dart';
import 'package:wm_rapor/wm_rapor_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWmRaporPlatform
    with MockPlatformInterfaceMixin
    implements WmRaporPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final WmRaporPlatform initialPlatform = WmRaporPlatform.instance;

  test('$MethodChannelWmRapor is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWmRapor>());
  });

  test('getPlatformVersion', () async {
    // WmRapor wmRaporPlugin = WmRapor();
    MockWmRaporPlatform fakePlatform = MockWmRaporPlatform();
    WmRaporPlatform.instance = fakePlatform;

    expect("await wmRaporPlugin.getPlatformVersion()", '42');
  });
}
