import UIKit
import Flutter
import Firebase




@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Registered for Apple Remote Notifications")
        Messaging.messaging().setAPNSToken(deviceToken, type: .unknown)
    }
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
  
      application.registerForRemoteNotifications()
      
      FirebaseApp.configure() //add this before the code below

     if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }

          GeneratedPluginRegistrant.register(with: self)



    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    
  
}
