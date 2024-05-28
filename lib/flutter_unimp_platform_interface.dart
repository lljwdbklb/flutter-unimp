import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:flutter/services.dart';

import 'flutter_unimp_method_channel.dart';

abstract class FlutterUnimpPlatform extends PlatformInterface {
  /// Constructs a FlutterUnimpPlatform.
  FlutterUnimpPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterUnimpPlatform _instance = MethodChannelFlutterUnimp();

  /// The default instance of [FlutterUnimpPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterUnimp].
  static FlutterUnimpPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterUnimpPlatform] when
  /// they register themselves.
  static set instance(FlutterUnimpPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool?> isExistsUniMP({required String appId}) {
    throw UnimplementedError('isExistsUniMP() has not been implemented.');
  }

  Future<Map?> getUniMPVersionInfo({required String appId}) {
    throw UnimplementedError('getUniMPVersionInfo() has not been implemented.');
  }

  Future<String?> getUniMPRunPath({required String appId}) {
    throw UnimplementedError('getUniMPRunPath() has not been implemented.');
  }

  Future<bool?> installUniMPResource({required String appId, required String wgtPath, String? password}) {
    throw UnimplementedError('installUniMPResource() has not been implemented.');
  }

  Future<Map?> openUniMP({required String appId, dynamic arguments}) {
    throw UnimplementedError('openUniMP() has not been implemented.');
  }

  Future<void> closeUniMP() {
    throw UnimplementedError('closeUniMP() has not been implemented.');
  }
  
  Future<void> sendUniMPEvent({required String event, dynamic data }) {
    throw UnimplementedError('closeUniMP() has not been implemented.');
  }

  void registerListener(Future<dynamic> Function(MethodCall call)? handler);

}
