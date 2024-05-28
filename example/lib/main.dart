import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_unimp/flutter_unimp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _flutterUnimpPlugin = FlutterUnimp();

  String appId1 = "__UNI__11E9B73";

  @override
  void initState() {
    super.initState();
    loadResource(appId1);
  }

  Future<bool> exists(path) async {
    final directory = await getApplicationDocumentsDirectory();
    String dirpath = directory.path;
    String newPath = '$dirpath/$path';
    Directory newDirectory = Directory(newPath);
    return await newDirectory.exists();
  }

  Future<String> createPath(String path) async {
    final directory = await getApplicationDocumentsDirectory();
    String dirpath = directory.path;
    print('temp dir: $dirpath');
    final pathList = path.split('/');
    String curPath = '';
    for (var element in pathList) {
      curPath = '$curPath/$element';
      String newPath = '$dirpath$curPath';
      Directory newDirectory = Directory(newPath);
      if (!await newDirectory.exists()) {
        try {
          await newDirectory.create();
        } catch (e) {
          print('create dir $e');
        }
      }
    }
    return '$dirpath$curPath';
  }

  Future<String> downloadFile(String appid) async {
    //模拟下载文件
    String downloadPath = await createPath('download');
    final ByteData data = await rootBundle.load('assets/$appid.wgt');
    final List<int> bytes = data.buffer.asUint8List();
    String toFilePath = '$downloadPath/$appid.wgt';

    final toFile = File(toFilePath);
    if (!await toFile.exists()) {
      await toFile.writeAsBytes(bytes);
    }
    return toFilePath;
  }

  Future<void> loadResource(String appid) async {
    bool isExists = await _flutterUnimpPlugin.isExistsUniMP(appId: appid);
    if (!isExists) {
      // 模拟下载
      String filePath = await downloadFile(appid);
      // 载入到
      bool isInstall = await _flutterUnimpPlugin.installUniMPResource(appId: appid, wgtPath: filePath);
      if (isInstall) {
        Map? versionInfo = await _flutterUnimpPlugin.getUniMPVersionInfo(appId: appid);
        print("小程序 $appid 应用资源文件部署成功，版本信息：$versionInfo");
      } else {
        print("小程序 $appid 应用资源部署失败");
      }
    } else {
      Map? versionInfo = await _flutterUnimpPlugin.getUniMPVersionInfo(appId: appid);
      print("已存在小程序 $appid 应用资源，版本信息：$versionInfo");
    }
  }

  void openMiniApp() async {
    Map? map = await _flutterUnimpPlugin.openUniMP(appId: appId1, arguments: { "launchInfo": "Hello UniMP" });
    print("已存在小程序 $map");
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: FloatingActionButton( onPressed: () {
            openMiniApp();
          },child: const Text('打开小程序'),),
        ),
      ),
    );
  }
}
