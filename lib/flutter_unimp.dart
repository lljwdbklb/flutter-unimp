
import 'package:flutter/services.dart';
import 'flutter_unimp_platform_interface.dart';

class FlutterUnimp {
  /// 运行目录中是否已经存在小程序资源
  /// [appId] appid
  Future<bool> isExistsUniMP({ required String appId}) async {
    return await FlutterUnimpPlatform.instance.isExistsUniMP(appId: appId) ?? false;
  }

  /// 获取已经部署的小程序应用资源版本信息
  /// [appId] appid
  /// 返回数据为 manifest 中的配置信息
  /// {
  ///     "name": "1.0.0",     // 应用版本名称
  ///     "code": 100          // 应用版本号
  /// }
  Future<Map?> getUniMPVersionInfo({required String appId}) async {
    return await FlutterUnimpPlatform.instance.getUniMPVersionInfo(appId: appId);
  }

  /// 获取 App 运行路径，注：需要将应用资源放到此路径下
  /// [appId] appid
  Future<String?> getUniMPRunPath({required String appId}) async {
    return await FlutterUnimpPlatform.instance.getUniMPRunPath(appId: appId);
  }

  /// 将wgt资源部署到运行路径中
  /// [appid] appid
  /// [wgtPath] wgt资源路径
  /// [password] wgt资源解压密码（没有密码传 nil）
  Future<bool> installUniMPResource({required String appId, required String wgtPath, String? password}) async {
    return await FlutterUnimpPlatform.instance.installUniMPResource(appId: appId, wgtPath: wgtPath, password: password) ?? false;
  }

  /// 启动小程序
  /// [appid] appid
  /// [arguments] 需要传递给目标小程序的数据
  Future<Map?> openUniMP({required String appId, dynamic arguments}) async {
    return await FlutterUnimpPlatform.instance.openUniMP(appId: appId, arguments: arguments);
  }

  /// 关闭当前显示的小程序应用
  Future<void> closeUniMP() async {
    return await FlutterUnimpPlatform.instance.closeUniMP();
  }
  
  /// 向当前打开的小程序发送消息事件
  /// [event] 事件名称
  /// [data] 数据
  Future<void> sendUniMPEvent({required String event, dynamic data }) async {
    return await FlutterUnimpPlatform.instance.sendUniMPEvent(event: event, data:data);
  }

  /// 小程序向原生发送消息的监听器
  void registerListener(Future<dynamic> Function(MethodCall call)? handler) {
    FlutterUnimpPlatform.instance.registerListener(handler);
  }
}
