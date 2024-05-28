import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_unimp_platform_interface.dart';

/// An implementation of [FlutterUnimpPlatform] that uses method channels.
class MethodChannelFlutterUnimp extends FlutterUnimpPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_unimp');

  @override
  Future<bool?> isExistsUniMP({required String appId}) async {
    final version = await methodChannel.invokeMethod<bool>('isExistsUniMP', {'appId': appId});
    return version;
  }

  @override
  Future<Map?> getUniMPVersionInfo({required String appId}) async {
    final version = await methodChannel.invokeMethod<Map>('getUniMPVersionInfo', {'appId': appId});
    return version;
  }

  @override
  Future<String?> getUniMPRunPath({required String appId}) async {
    final version = await methodChannel.invokeMethod<String>('getUniMPRunPath', {'appId': appId});
    return version;
  }

  @override
  Future<bool?> installUniMPResource({required String appId, required String wgtPath, String? password}) async {
    final version = await methodChannel.invokeMethod<bool>('installUniMPResource', {'appId': appId, "wgtPath": wgtPath, "password": password});
    return version;
  }

  @override
  Future<Map<String, dynamic>?> openUniMP({required String appId, dynamic arguments}) async {
    final version = await methodChannel.invokeMethod<Map<String, dynamic>>('openUniMP', {'appId': appId, "arguments": arguments});
    return version;
  }

  @override
  Future<void> closeUniMP() async {
    await methodChannel.invokeMethod<Map>('closeUniMP');
  }

  @override
  Future<void> sendUniMPEvent({required String event, dynamic data }) async {
    await methodChannel.invokeMethod<Map>('sendUniMPEvent', {'appId': event, "data": data});
  }

  @override
  void registerListener(Future<dynamic> Function(MethodCall call)? handler) {
    methodChannel.setMethodCallHandler(handler);
  }
}
