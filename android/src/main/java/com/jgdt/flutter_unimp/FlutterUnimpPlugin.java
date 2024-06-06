package com.jgdt.flutter_unimp;

import androidx.annotation.NonNull;

import io.dcloud.feature.sdk.Interface.IUniMP;
import io.dcloud.feature.unimp.config.IUniMPReleaseCallBack;
import io.dcloud.feature.unimp.config.UniMPOpenConfiguration;
import io.dcloud.feature.unimp.config.UniMPReleaseConfiguration;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import io.dcloud.feature.sdk.DCSDKInitConfig;
import io.dcloud.feature.sdk.DCUniMPSDK;
import io.dcloud.feature.sdk.Interface.IDCUniMPPreInitCallback;
import io.dcloud.feature.sdk.MenuActionSheetItem;
import android.content.Context;
import android.util.Log;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;

import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/** FlutterUnimpPlugin */
public class FlutterUnimpPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  private Context context;
  private static final String TAG = "FlutterUnimpPlugin"; // 定义一个

  IUniMP uniMP = null;
  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_unimp");
    channel.setMethodCallHandler(this);
    context = flutterPluginBinding.getApplicationContext();


    //初始化 uni小程序SDK ----start----------
    // MenuActionSheetItem item = new MenuActionSheetItem("关于", "gy");

    // MenuActionSheetItem item1 = new MenuActionSheetItem("获取当前页面url", "hqdqym");
    // MenuActionSheetItem item2 = new MenuActionSheetItem("跳转到宿主原生测试页面", "gotoTestPage");
    List<MenuActionSheetItem> sheetItems = new ArrayList<>();
    // sheetItems.add(item);
    // sheetItems.add(item1);
    // sheetItems.add(item2);
    Log.i("unimp","onCreate----");
    DCSDKInitConfig config = new DCSDKInitConfig.Builder()
            .setCapsule(true)
            .setMenuDefFontSize("16px")
            // .setMenuDefFontColor("#ff00ff")
            .setMenuDefFontWeight("normal")
            .setMenuActionSheetItems(sheetItems)
            .setEnableBackground(false)//开启后台运行
            // .setUniMPFromRecents(false)
            .build();
    DCUniMPSDK.getInstance().initialize(context, config, new IDCUniMPPreInitCallback() {
        @Override
        public void onInitFinished(boolean b) {
            Log.d("unimpaa","onInitFinished----"+b);
        }
    });
    //初始化 uni小程序SDK ----end----------
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("isExistsUniMP")) {
      String appId = call.argument("appId");
      result.success(DCUniMPSDK.getInstance().isExistsApp(appId));
    } else if (call.method.equals("getUniMPVersionInfo")) {
      String appId = call.argument("appId");
      JSONObject obj = DCUniMPSDK.getInstance().getAppVersionInfo(appId);

      result.success(JSON.parseObject(obj.toString(), new TypeReference<Map<String, String>>(){}));
    } else if (call.method.equals("getUniMPRunPath")) {
      String appId = call.argument("appId");
      result.success(context.getExternalCacheDir().getPath()+"/"+appId+".wgt");
    } else if (call.method.equals("installUniMPResource")) {
      String appId = call.argument("appId");
      String wgtPath = call.argument("wgtPath");
      String password = call.argument("password");
      UniMPReleaseConfiguration uc = new UniMPReleaseConfiguration();
      uc.wgtPath = wgtPath;
      uc.password = password;
      DCUniMPSDK.getInstance().releaseWgtToRunPath(appId, uc, new IUniMPReleaseCallBack() {
        @Override
        public void onCallBack(int code, Object o) {
          if(code == 1) {
            //释放wgt完成
            Log.i(TAG,"释放wgt完成");
            result.success(true);

          } else{
            //释放wgt失败
            Log.e(TAG,"释放wgt失败");
            result.success(false);

          }
        }
      });
      // result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if (call.method.equals("openUniMP")) {
//      String path = call.argument("path");
      String appId = call.argument("appId");
      HashMap<String,Object> extraData = call.argument("arguments");

      Log.v(TAG, "打开小程序-----------appid:"+ appId + "----extraData:"+ extraData);


      UniMPOpenConfiguration uniMPOpenConfiguration = new UniMPOpenConfiguration();
      uniMPOpenConfiguration.extraData = new JSONObject(extraData);
      // if (Objects.nonNull(extraData)) {
      //     JSONObject par = new JSONObject(extraData);
      //     uniMPOpenConfiguration.extraData = par;
      // }

      // uniMPOpenConfiguration.path = path;
      // uniMPOpenConfiguration.redirectPath = "pages/index/index";
        Map<String,String> re = new HashMap<>();

        try {
            uniMP = DCUniMPSDK.getInstance().openUniMP(context,appId, uniMPOpenConfiguration);
        } catch (Exception e) {
          re.put("errCode","-1");
          re.put("errMsg",e.getMessage());
//          result.success(re);
        }
      re.put("errCode","0");
      re.put("errMsg","");
        JSONObject obj = new JSONObject(re);
        result.success(JSON.parseObject(obj.toString(), new TypeReference<Map<String, String>>(){}));
    } else if (call.method.equals("closeUniMP")) {
//      String appid = call.argument("appid");
//      IUniMP uniMP = mUniMPCaches.get(appid);
    if(uniMP!=null){
      uniMP.closeUniMP();
    }
      // result.success("关闭小程序成功 ");
      result.notImplemented();
    } else if (call.method.equals("sendUniMPEvent")) {
      String event = call.argument("event");
      HashMap<String,Object> data = call.argument("data");
      if(uniMP!=null){
        uniMP.sendUniMPEvent(event,data);
      }
      result.notImplemented();
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
