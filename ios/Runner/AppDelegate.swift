import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      
      let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
      let deviceInfoChannel = FlutterMethodChannel(name: "com.example/device_info",
                                                   binaryMessenger: controller.binaryMessenger)
      
      deviceInfoChannel.setMethodCallHandler { (call, result) in
          if call.method == "fetchDeviceInfo" {
              result(self.fetchDeviceInfo())
          } else {
              result(FlutterMethodNotImplemented)
          }
      }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func fetchDeviceInfo() -> [String: String] {
        let device = UIDevice.current
        return [
            "model": device.model,
            "systemVersion": device.systemVersion
        ]
    }
}

