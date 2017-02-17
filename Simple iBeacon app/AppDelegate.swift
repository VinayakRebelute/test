 //
//  AppDelegate.swift
//  Simple iBeacon app
//
//  Created by Alphanso Tech on 14/12/15.
//  Copyright © 2015 Alphanso Tech. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications
let requestIdentifier = "SampleRequest"
 


var PUSH_NOTIFICATION_FLAG : Bool = false
var MY_COUPON_ID : String = ""
 var MY_SURVEY_ID : String = ""



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,CLLocationManagerDelegate,UNUserNotificationCenterDelegate {

    var window: UIWindow?
    let locationManager = CLLocationManager()

    let constant = constants()
    var activityIndicatorView: ActivityIndicatorView!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if let payload = launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] as? NSDictionary
        {
            var categoryId = ""
            var threadId = ""
            
            if let aps = payload["aps"] as? NSDictionary {
                
                print(aps["alert"] as? String)
                print(aps["category"] as? String)
                print(aps["thread-id"] as? String)
                
                
                categoryId = (aps["category"] as? String)!
                threadId   = (aps["thread-id"] as? String)!
                // content.body = (aps["alert"] as? String)!
                // content.sound = UNNotificationSound.default()
                //
            }
            if categoryId == "Survey"
            {
                PUSH_NOTIFICATION_FLAG = true
                MY_SURVEY_ID = threadId
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "LoginStoryBoardID") as! LoginViewController
                let navigationController = storyboard.instantiateViewController(withIdentifier: "NavigationContollerID")  as! UINavigationController
                self.window?.rootViewController = navigationController
                self.window?.makeKeyAndVisible()
                
                
                navigationController.pushViewController(vc, animated: false)
            }
            else if categoryId == "Coupon"
            {
                // PUSH_NOTIFICATION_FLAG = true
                UserDefaults.standard.set("1", forKey: "CouponComes")
                MY_COUPON_ID = threadId
                
                
                let vc1 = LoginViewController()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc2 = storyboard.instantiateViewController(withIdentifier: "HomeStoryBoardID") as! ViewController
                let navigationController = storyboard.instantiateViewController(withIdentifier: "NavigationContollerID")  as! UINavigationController
                self.window?.rootViewController = navigationController
                self.window?.makeKeyAndVisible()
                
                
                navigationController.pushViewController(vc1, animated: false)
                navigationController.pushViewController(vc2, animated: false)
            }
            
        }
        
        application.registerForRemoteNotifications()
        
       locationManager.delegate = self
        

        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
                // Enable or disable features based on authorization.
            }

        } else {
            
             let notificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        
            UIApplication.shared.registerUserNotificationSettings(notificationSettings)
            // Fallback on earlier versions
        }
              return true
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
        // Tells the delegate that the user entered in iBeacon range or area.
        
      //  UserDefaults.standard.set("1", forKey: "CouponComes")
      //  UserDefaults.standard.set(region.identifier, forKey: "RegionID")
        
     /*
        if #available(iOS 10.0, *) {
            let content = UNMutableNotificationContent()
            content.body = "Welcome to store"
            content.sound = UNNotificationSound.default()
            let request = UNNotificationRequest(identifier:region.identifier, content: content, trigger: nil)
            
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

            UNUserNotificationCenter.current().add(request){(error) in
                
                if (error != nil){
                    
                    //  print(error?.localizedDescription ?? )
                }
            }

        } else {
            
            
            let notification = UILocalNotification()
            notification.alertBody = "Welcome to store"
        //    notification.alertAction = "be awesome!"
            notification.soundName = UILocalNotificationDefaultSoundName
          //  notification.userInfo = ["CustomField1": "w00t"]
            UIApplication.shared.scheduleLocalNotification(notification)

            // Fallback on earlier versions
          
        }
        */
      MY_COUPON_ID = region.identifier
      //  let vc = ViewController()
      //  vc.WebSeviceGetCouponWithRegion()
        
        
        
        
        
        
        
        var urlStr : NSString = NSString(format:"%@%@",constant.baseUrl,constant.getBeaconRelatedCoupon)
        urlStr = urlStr.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
        
        
        
      //  let activeVc = UIApplication.shared.keyWindow?.rootViewController
        
      //  self.activityIndicatorView = ActivityIndicatorView(title: "Processing...", center: (activeVc?.view.center)!)
        
      //  activeVc?.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())
      //  activityIndicatorView.startAnimating()
        // let userName = txtUserName.text!.aesEncrypt()
        // let ID =  USERUNIQUEID.aesEncrypt()
       // UserDefaults.standard.set(deviceTokenString, forKey: "DeviceID")

      var  DeviceToken = ""
        if UserDefaults.standard.value(forKey: "DeviceID") != nil {
            DeviceToken =  UserDefaults.standard.value(forKey: "DeviceID") as! String
        }
        let str : NSString = NSString(format: "device_id=%@&device_type=%@&beacon=%@",DeviceToken,"2",region.identifier)
        
        
        constant.PerformRequestwith(urlStr, strparam: str,methodUsed:"POST") { (data,errorType,errorMEssage) -> () in
            
            if (data != nil)
            {
                
                print("data added successfully")
                
            }
                
                
            else
                
            {
                let alertController = UIAlertController(title: errorType, message: errorMEssage, preferredStyle: .alert)
                
                
                
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                
                
                let activeVc = UIApplication.shared.keyWindow?.rootViewController
                
                
                activeVc?.present(alertController, animated: true, completion: nil)
            }
        }


        
    }
    
        func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
            
            // Tells the delegate that the user exit the iBeacon range or area.
     /*
            if #available(iOS 10.0, *) {
                let content = UNMutableNotificationContent()
                content.body = "Thank You Visit Again"
                content.sound = UNNotificationSound.default()
                let request = UNNotificationRequest(identifier:self.generateRandomStringWithLength(length: 5), content: content, trigger: nil)
                
                UNUserNotificationCenter.current().delegate = self
                UNUserNotificationCenter.current().add(request){(error) in
                    
                    if (error != nil){
                        
                        //  print(error?.localizedDescription ?? )
                    }
                }
                
            } else {
                let notification = UILocalNotification()
                notification.alertBody = "Thank You Visit Again"
                //    notification.alertAction = "be awesome!"
                notification.soundName = UILocalNotificationDefaultSoundName
                //  notification.userInfo = ["CustomField1": "w00t"]
                UIApplication.shared.scheduleLocalNotification(notification)
            
            /* This method called because
             
             beaconRegion.notifyOnExit = true
             
             in setupBeacon() function
             */
            
        }
            
        */
        /* This method called because
         
         beaconRegion.notifyOnEntry = true
         
         in setupBeacon() function
         */
        
        
    }

    
    
    
   
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
  //  MARK:- ------------------------- PUSH Notification Code ---------------- -
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Convert token to string
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        
        UserDefaults.standard.set(deviceTokenString, forKey: "DeviceID")
        if UserDefaults.standard.bool(forKey: "AppLunchFirstTime") != true
        {
           self.webServiceCall(deviceTokenString)
            
        }
        
        // Print it to console
        print("APNs device token: \(deviceTokenString)")
        
        // Persist it in your backend in case it's new
    }
    
     func webServiceCall(_ DeviceToken : String)
     {
     var urlStr : NSString = NSString(format:"%@",constant.RegisterDeviceToken)
     urlStr = urlStr.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
     
     
     
     let activeVc = UIApplication.shared.keyWindow?.rootViewController
     
     self.activityIndicatorView = ActivityIndicatorView(title: "Processing...", center: (activeVc?.view.center)!)
     
     activeVc?.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())
     activityIndicatorView.startAnimating()
        
     let str : NSString = NSString(format: "device_id=%@&device_type=%@",DeviceToken,"2")
     
     
     constant.PerformRequestwith(urlStr, strparam: str,methodUsed:"POST") { (data,errorType,errorMEssage) -> () in
     self.activityIndicatorView.stopAnimating()
     
     if (data != nil)
     {
     
     UserDefaults.standard.set(true, forKey: "AppLunchFirstTime")
     
     }
     
     
     else
     
     {
     let alertController = UIAlertController(title: errorType, message: errorMEssage, preferredStyle: .alert)
     
     
     
     alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
     
     }))
     
     
     
     let activeVc = UIApplication.shared.keyWindow?.rootViewController
     
     
     activeVc?.present(alertController, animated: true, completion: nil)
     }
     }
     
     }

    // Called when APNs failed to register the device for push notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Print the error to console (you should alert the user that registration failed)
        print("APNs registration failed: \(error)")
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
        // Print notification payload data
        print("Push notification received: \(data)")
        
                
        if application.applicationState == .active
        {

            if #available(iOS 10.0, *) {
              
                let content = UNMutableNotificationContent()

                if let aps = data["aps"] as? NSDictionary {
                    
                    print(aps["alert"] as? String)
                      print(aps["thread-id"] as? String)
                    print(aps["thread-id"] as? String)
                    content.body = (aps["alert"] as? String)!
                    content.sound = UNNotificationSound.default()
                    
                }
                let request = UNNotificationRequest(identifier:self.generateRandomStringWithLength(length: 5), content: content, trigger: nil)
                UNUserNotificationCenter.current().delegate = self
                UNUserNotificationCenter.current().add(request){(error) in
                    
                    if (error != nil){
                        
                        //  print(error?.localizedDescription ?? )
                    }
                }
            } else {
                // Fallback on earlier versions
            }
        
//            if Identifier == "Survey"
//            {
//                PUSH_NOTIFICATION_FLAG = true
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let vc = storyboard.instantiateViewController(withIdentifier: "LoginStoryBoardID") as! LoginViewController
//                let navigationController = application.windows[0].rootViewController as! UINavigationController
//                
//                navigationController.pushViewController(vc, animated: false)
//            }
//            else
//            {
//                // PUSH_NOTIFICATION_FLAG = true
//                MY_COUPON_ID = Identifier
//                UserDefaults.standard.set("1", forKey: "CouponComes")
//                
//                let vc1 = LoginViewController()
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let vc2 = storyboard.instantiateViewController(withIdentifier: "HomeStoryBoardID") as! ViewController
//                let navigationController = application.windows[0].rootViewController as! UINavigationController
//                
//                navigationController.pushViewController(vc1, animated: false)
//                navigationController.pushViewController(vc2, animated: false)
//            }
//         
//         
//            
//        }
        }
            
        else
        {
           // let rootViewController = self.window?.rootViewController as! LoginViewController
            
            var categoryId = ""
             var threadId = ""
            
            if let aps = data["aps"] as? NSDictionary {
                
                print(aps["alert"] as? String)
                print(aps["category"] as? String)
                print(aps["thread-id"] as? String)
                
                
                categoryId = (aps["category"] as? String)!
                threadId   = (aps["thread-id"] as? String)!
               // content.body = (aps["alert"] as? String)!
               // content.sound = UNNotificationSound.default()
               //
            }
            if categoryId == "Survey"
            {
                PUSH_NOTIFICATION_FLAG = true
                MY_SURVEY_ID = threadId
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "LoginStoryBoardID") as! LoginViewController
                let navigationController = storyboard.instantiateViewController(withIdentifier: "NavigationContollerID")  as! UINavigationController
                self.window?.rootViewController = navigationController
                self.window?.makeKeyAndVisible()
                
                
                navigationController.pushViewController(vc, animated: false)
            }
            else if categoryId == "Coupon"
            {
                // PUSH_NOTIFICATION_FLAG = true
                UserDefaults.standard.set("1", forKey: "CouponComes")
                MY_COUPON_ID = threadId
                
                
                let vc1 = LoginViewController()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc2 = storyboard.instantiateViewController(withIdentifier: "HomeStoryBoardID") as! ViewController
                let navigationController = storyboard.instantiateViewController(withIdentifier: "NavigationContollerID")  as! UINavigationController
                self.window?.rootViewController = navigationController
                self.window?.makeKeyAndVisible()
                
                
                navigationController.pushViewController(vc1, animated: false)
                navigationController.pushViewController(vc2, animated: false)
            }
            
            
        }
        
        
        
        
        
        
    }
    
    
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Tapped in notification")
       //  print(response.actionIdentifier)
       
         let id = response.notification.request.identifier
         print("categoryIdentifier is: \(response.notification.request.content.categoryIdentifier)")
         print("threadIdentifier is: \(response.notification.request.content.threadIdentifier)")
        
        
        
        
        if response.notification.request.content.categoryIdentifier == "Survey"
        {
            PUSH_NOTIFICATION_FLAG = true
            MY_SURVEY_ID = response.notification.request.content.threadIdentifier
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginStoryBoardID") as! LoginViewController
            let navigationController = storyboard.instantiateViewController(withIdentifier: "NavigationContollerID")  as! UINavigationController
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
            
            
            navigationController.pushViewController(vc, animated: false)
        }
        else if response.notification.request.content.categoryIdentifier == "Coupon"
        {
            // PUSH_NOTIFICATION_FLAG = true
            UserDefaults.standard.set("1", forKey: "CouponComes")
            MY_COUPON_ID = response.notification.request.content.threadIdentifier
            
            
            let vc1 = LoginViewController()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc2 = storyboard.instantiateViewController(withIdentifier: "HomeStoryBoardID") as! ViewController
            let navigationController = storyboard.instantiateViewController(withIdentifier: "NavigationContollerID")  as! UINavigationController
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()

            
            navigationController.pushViewController(vc1, animated: false)
            navigationController.pushViewController(vc2, animated: false)
        }
        
        
        
       // response.notification.request.content.categoryIdentifier
      //  print("Identifier is: \(id)")
        
      //  response.notification.request.content.
      
    
//        let rootViewController = self.window?.rootViewController as! LoginViewController
//        
//        NOTIFICATION_FLAG = true
//        //      let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        //  let vc = storyboard.instantiateViewController(withIdentifier: "HomestoryboardID") as! ViewController
//        rootViewController.performSegue(withIdentifier: "surveySegueId", sender: self)
        
    }
    
//    private func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [NSObject : AnyObject], completionHandler: @escaping () -> Void) {
//        // 1
//        let aps = userInfo["aps"] as! [String: AnyObject]
//        
//        // 2
//        if let newsItem = createNewNewsItem(aps) {
//            (window?.rootViewController as? UITabBarController)?.selectedIndex = 1
//            
//            // 3
//            if identifier == "VIEW_IDENTIFIER", let url = NSURL(string: newsItem.link) {
//                let safari = SFSafariViewController(URL: url)
//                window?.rootViewController?.presentViewController(safari, animated: true, completion: nil)
//            }
//        }
//        
//        // 4
//        completionHandler()
//    }
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("Notification being triggered")
        
       
        //You can either present alert ,sound or increase badge while the app is in foreground too with ios 10
        //to distinguish between notifications
        
        completionHandler( [.alert,.sound,.badge])
        
        
        
    }
    
    func generateRandomStringWithLength(length:Int) -> String {
        
        let randomString:NSMutableString = NSMutableString(capacity: length)
        
        let letters:NSMutableString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        var i: Int = 0
        
        while i < length {
            
            let randomIndex:Int = Int(arc4random_uniform(UInt32(letters.length)))
            randomString.append("\(Character( UnicodeScalar( letters.character(at: randomIndex))!))")
            i += 1
        }
        
        return String(randomString)
    }


}

