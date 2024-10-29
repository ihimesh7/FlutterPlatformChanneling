import UIKit
import Flutter

@UIApplicationMain
class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let nativeChannel = FlutterMethodChannel(name: "com.example.platform_channeling/native",
                                              binaryMessenger: controller.binaryMessenger)

    nativeChannel.setMethodCallHandler { (call, result) in
      if call.method == "getNativeMessage" {
        result("Hello from iOS native code!")
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    GeneratedPluginRegistrant.register(with: self)
    return true
  }
}
