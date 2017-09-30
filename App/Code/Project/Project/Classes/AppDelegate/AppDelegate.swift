
import UIKit

import Log
import NetworkKit

let Log = Logger()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        Application.shared.configureMainInterface(in: window!)

        // Mock Notifications for developing
        //        if TRNManagerEnvironment.isDebug {
        //            if UIDevice.isSimulator {
        //                UIApplication.shared.listenForRemoteNotifications()
        //                UIApplication.shared.remoteNotificationsPort = 9930 // Default port
        //            }
        //        }

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {

    }

    //
    // MARK: URL Scheme
    //

    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {

        return false
    }

    func openUrl(_ url: URL) {

    }

    //
    // MARK: Remote notifications
    //

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {

    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {

    }

}

//
// MARK: Computed Variables
//
extension AppDelegate {
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as? AppDelegate ?? AppDelegate()
    }
}
