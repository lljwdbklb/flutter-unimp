import 'package:flutter/src/services/message_codec.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_unimp/flutter_unimp.dart';
import 'package:flutter_unimp/flutter_unimp_platform_interface.dart';
import 'package:flutter_unimp/flutter_unimp_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterUnimpPlatform
    with MockPlatformInterfaceMixin
    implements FlutterUnimpPlatform {

  @override
  Future<void> closeUniMP() {
    // TODO: implement closeUniMP
    throw UnimplementedError();
  }

  @override
  Future<String?> getUniMPRunPath({required String appId}) {
    // TODO: implement getUniMPRunPath
    throw UnimplementedError();
  }

  @override
  Future<Map?> getUniMPVersionInfo({required String appId}) {
    // TODO: implement getUniMPVersionInfo
    throw UnimplementedError();
  }

  @override
  Future<bool?> installUniMPResource({required String appId, required String wgtPath, String? password}) {
    // TODO: implement installUniMPResource
    throw UnimplementedError();
  }

  @override
  Future<bool?> isExistsUniMP({required String appId}) {
    // TODO: implement isExistsUniMP
    throw UnimplementedError();
  }

  @override
  Future<Map?> openUniMP({required String appId, arguments}) {
    // TODO: implement openUniMP
    throw UnimplementedError();
  }

  @override
  void registerListener(Future Function(MethodCall call)? handler) {
    // TODO: implement registerListener
  }

  @override
  Future<void> sendUniMPEvent({required String event, data}) {
    // TODO: implement sendUniMPEvent
    throw UnimplementedError();
  }
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

    // expect(await flutterUnimpPlugin.getPlatformVersion(), '42');
  });
}
