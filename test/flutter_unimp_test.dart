import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_unimp/flutter_unimp.dart';
import 'package:flutter_unimp/flutter_unimp_platform_interface.dart';
import 'package:flutter_unimp/flutter_unimp_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterUnimpPlatform
    with MockPlatformInterfaceMixin
    implements FlutterUnimpPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterUnimpPlatform initialPlatform = FlutterUnimpPlatform.instance;

  test('$MethodChannelFlutterUnimp is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterUnimp>());
  });

  test('getPlatformVersion', () async {
    FlutterUnimp flutterUnimpPlugin = FlutterUnimp();
    MockFlutterUnimpPlatform fakePlatform = MockFlutterUnimpPlatform();
    FlutterUnimpPlatform.instance = fakePlatform;

    expect(await flutterUnimpPlugin.getPlatformVersion(), '42');
  });
}
