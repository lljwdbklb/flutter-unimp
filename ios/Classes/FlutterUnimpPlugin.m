#import "FlutterUnimpPlugin.h"
#import "DCUniMP.h"
#import "FlutterUnimpSplashView.h"

@interface FlutterUnimpPlugin()<DCUniMPSDKEngineDelegate>
@property(weak, nonatomic) DCUniMPInstance * uniMPInstance;
@property(weak, nonatomic) FlutterMethodChannel* channel;
@end

@implementation FlutterUnimpPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_unimp"
            binaryMessenger:[registrar messenger]];
  FlutterUnimpPlugin* instance = [[FlutterUnimpPlugin alloc] init];
  instance.channel = channel;
  [registrar addMethodCallDelegate:instance channel:channel];
  [registrar addApplicationDelegate:instance];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"isExistsUniMP" isEqualToString:call.method]) {
    NSString *appId = call.arguments[@"appId"];
    result(@([DCUniMPSDKEngine isExistsUniMP:appId]));
  } else if([@"getUniMPVersionInfo" isEqualToString:call.method]) {
    NSString *appId = call.arguments[@"appId"];
    result([DCUniMPSDKEngine getUniMPVersionInfoWithAppid:appId]);
  } else if([@"getUniMPRunPath" isEqualToString:call.method]) {
    NSString *appId = call.arguments[@"appId"];
    result([DCUniMPSDKEngine getUniMPRunPathWithAppid:appId]);
  } else if([@"installUniMPResource" isEqualToString:call.method]) {
    NSString *appId = call.arguments[@"appId"];
    NSString *wgtPath = call.arguments[@"wgtPath"];
    NSString *password = call.arguments[@"password"];
    if ([password isKindOfClass:[NSNull class]]) {
        password = nil;
    }
    NSError *error;
    result(@([DCUniMPSDKEngine installUniMPResourceWithAppid:appId 
                                            resourceFilePath:wgtPath
                                                    password:password
                                                      error:&error]));
    if (error) {
      NSLog(@"[DCUniMPSDKEngine installUniMPResourceWithAppid:resourceFilePath:password:error:] %@", error);
    }
  } else if([@"openUniMP" isEqualToString:call.method]) {
    NSString *appId = call.arguments[@"appId"];
    NSDictionary *arguments = call.arguments[@"arguments"];
    // 获取配置信息
    DCUniMPConfiguration *configuration = [[DCUniMPConfiguration alloc] init];
    configuration.extraData = arguments;
    __weak __typeof(self)weakSelf = self;
    [DCUniMPSDKEngine openUniMP:appId configuration:configuration completed:^(DCUniMPInstance * _Nullable uniMPInstance, NSError * _Nullable error) {
        if (uniMPInstance) {
            weakSelf.uniMPInstance = uniMPInstance;
            NSLog(@"打开小程序成功");
            result(@{@"errCode": @(0), @"errMsg": @""});
        } else {
            NSLog(@"打开小程序出错：%@",error);
            result(@{@"errCode": @(error.code), @"errMsg": error.localizedDescription});
        }
    }];
  } else if([@"closeUniMP" isEqualToString:call.method]) {
    [DCUniMPSDKEngine closeUniMP];
    result(FlutterMethodNotImplemented);
  } else if ([@"sendUniMPEvent"isEqualToString:call.method]) {
    NSString *event = call.arguments[@"event"];
    NSDictionary *arguments = call.arguments[@"data"];
    if (self.uniMPInstance) {
      [self.uniMPInstance sendUniMPEvent:event data:arguments];
    }
    result(FlutterMethodNotImplemented);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

#pragma mark - DCUniMPSDKEngineDelegate
/// 胶囊按钮‘x’关闭按钮点击回调
- (void)closeButtonClicked:(NSString *)appid {
    NSLog(@"点击了 小程序 %@ 的关闭按钮",appid);
}

/// DCUniMPMenuActionSheetItem 点击触发回调方法
- (void)defaultMenuItemClicked:(NSString *)appid identifier:(NSString *)identifier {
    
}

/// 返回打开小程序时的自定义闪屏视图
- (UIView *)splashViewForApp:(NSString *)appid {
    UIView *splashView = [[FlutterUnimpSplashView alloc] init];
    return splashView;
}

/// 小程序关闭回调方法
- (void)uniMPOnClose:(NSString *)appid {
    NSLog(@"小程序 %@ 被关闭了",appid);
    self.uniMPInstance = nil;
}


/// 小程序向原生发送事件回调方法
/// @param appid 对应小程序的appid
/// @param event 事件名称
/// @param data 数据：NSString 或 NSDictionary 类型
/// @param callback 回调数据给小程序
- (void)onUniMPEventReceive:(NSString *)appid event:(NSString *)event data:(id)data callback:(DCUniMPKeepAliveCallback)callback {
    NSLog(@"Receive UniMP:%@ event:%@ data:%@",appid,event,data);
    [self.channel invokeMethod:event arguments:data result:^(id  _Nullable result) {
        if (callback) {
            callback(result, NO);
        }
    }];
}

#pragma mark - App 生命周期方法
- (BOOL)application:(UIApplication*)application
    didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"调用生命周期初始化");
    // 配置参数
    NSMutableDictionary *options = [NSMutableDictionary dictionaryWithDictionary:launchOptions];
    // 设置 debug YES 会在控制台输出 js log，默认不输出 log，注：需要引入 liblibLog.a 库
    [options setObject:[NSNumber numberWithBool:YES] forKey:@"debug"];
    // 初始化引擎
    [DCUniMPSDKEngine initSDKEnvironmentWithLaunchOptions:options];
    [DCUniMPSDKEngine setDelegate:self];
    return YES;
}

#pragma mark - 如果需要使用 URL Scheme 或 通用链接相关功能，请实现以下方法
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    // 通过 url scheme 唤起 App
    [DCUniMPSDKEngine application:app openURL:url options:options];
    return YES;
}

- (BOOL)application:(UIApplication*)application
    continueUserActivity:(NSUserActivity*)userActivity
      restorationHandler:(void (^)(NSArray*))restorationHandler {
    // 通过通用链接唤起 App
    [DCUniMPSDKEngine application:application continueUserActivity:userActivity];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [DCUniMPSDKEngine applicationDidBecomeActive:application];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [DCUniMPSDKEngine applicationWillResignActive:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [DCUniMPSDKEngine applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [DCUniMPSDKEngine applicationWillEnterForeground:application];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [DCUniMPSDKEngine destory];
}

//MARK: - get set

@end
