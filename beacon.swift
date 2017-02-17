//
//  beacon.swift
//  Becon Test
//
//  Created by Alphanso Tech on 04/12/15.
//  Copyright © 2015 Alphanso Tech. All rights reserved.
//

import UIKit
import CoreLocation

extension ViewController: CLLocationManagerDelegate {
    
        func setupBeacon() {

            locationManager.delegate = self
           
          var i = 0
            for _ in self.BeaconName
            {
                let uuid = UUID(uuidString: self.BeaconId[i])!
                
                // Use identifier like your company name or website
                let identifier = self.BeaconName[i]
                
                let Major:CLBeaconMajorValue = UInt16(self.BeaconMajor[i])!
                let Minor:CLBeaconMinorValue = UInt16(self.BeaconMinor[i])!
                
                let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: Major, minor: Minor, identifier: identifier)
                
                // called delegate when Enter iBeacon Range
                beaconRegion.notifyOnEntry = true
                
                // called delegate when Exit iBeacon Range
                beaconRegion.notifyOnExit = true
                
                i += 1
                locationManager.startMonitoring(for: beaconRegion)
                  locationManager.startRangingBeacons(in: beaconRegion)

            }
            
            // Enter Your iBeacon UUID

//            let uuid = UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!
//            
//            // Use identifier like your company name or website
//            let identifier = "blueberry"
//            
//            let Major:CLBeaconMajorValue = 55380
//            let Minor:CLBeaconMinorValue = 46539
//            
//            let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: Major, minor: Minor, identifier: identifier)
//            
//            // called delegate when Enter iBeacon Range
//            beaconRegion.notifyOnEntry = true
//            
//            // called delegate when Exit iBeacon Range
//            beaconRegion.notifyOnExit = true
//            
            
            
            
//            // Enter Your iBeacon UUID
//            let uuid1 = UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!
//            
//            // Use identifier like your company name or website
//            let identifier1 = "ice"
//            
//            let Major1:CLBeaconMajorValue = 4463
//            let Minor1:CLBeaconMinorValue = 9556
//            
//            let beaconRegion1 = CLBeaconRegion(proximityUUID: uuid1, major: Major1, minor: Minor1, identifier: identifier1)
//            
//            // called delegate when Enter iBeacon Range
//            beaconRegion1.notifyOnEntry = true
//            
//            // called delegate when Exit iBeacon Range
//            beaconRegion1.notifyOnExit = true
//
//            
//            
//            
//            // Enter Your iBeacon UUID
//            let uuid2 = UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!
//            
//            // Use identifier like your company name or website
//            let identifier2 = "mint"
//            
//            let Major2:CLBeaconMajorValue = 12311
//            let Minor2:CLBeaconMinorValue = 64064
//            
//            let beaconRegion2 = CLBeaconRegion(proximityUUID: uuid2, major: Major2, minor: Minor2, identifier: identifier2)
//            
//            // called delegate when Enter iBeacon Range
//            beaconRegion2.notifyOnEntry = true
//            
//            // called delegate when Exit iBeacon Range
//            beaconRegion2.notifyOnExit = true
            
            
            // Requests permission to use location services
           
            
//            locationManager.startMonitoring(for: beaconRegion1)
//            locationManager.startMonitoring(for: beaconRegion2)


            locationManager.requestAlwaysAuthorization()
            
            // Starts monitoring the specified iBeacon Region
            locationManager.pausesLocationUpdatesAutomatically = false
            
        }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
            
        case .authorizedAlways:
            // Starts the generation of updates that report the user’s current location.
            locationManager.startUpdatingLocation()

        case .restricted:
            
            // Your app is not authorized to use location services.
            
            simpleAlert("Permission Error", message: "Need Location Service Permission To Access Beacon")


        case .denied:
            
            // The user explicitly denied the use of location services for this app or location services are currently disabled in Settings.
            
           simpleAlert("Permission Error", message: "Need Location Service Permission To Access Beacon")

        default:
            // handle .NotDetermined here
            
            // The user has not yet made a choice regarding whether this app can use location services.
            break
        }
    }
    
    func simpleAlert (_ title:String,message:String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        
        // Tells the delegate that a iBeacon Area is being monitored
        
        locationManager.requestState(for: region)
    }
  
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
       
//        UserDefaults.standard.set("1", forKey: "CouponComes")
//        UserDefaults.standard.set(region.identifier, forKey: "RegionID")
//        self.WebSeviceGetCouponWithRegion()


//        if region.identifier == "Ice"
//        {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "LoginStoryBoardID") as! LoginViewController
//            
//            navigationController?.pushViewController(vc, animated: false)
//        }
//        else
//        {
//            UserDefaults.standard.set("1", forKey: "CouponComes")
//            UserDefaults.standard.set(region.identifier, forKey: "RegionID")
//            self.WebSeviceGetCouponWithRegion()
//        }
        
        
        
        // Tells the delegate that the user entered in iBeacon range or area.
        
       
       // self.tblBcon.reloadData()
   //    simpleAlert("Welcome", message: "Welcome to our store")
        
//        let notification = UILocalNotification()
//        notification.alertBody =
//            "Your gate closes in 47 minutes. " +
//            "Current security wait time is 15 minutes, " +
//            "and it's a 5 minute walk from security to the gate. " +
//        "Looks like you've got plenty of time!"
//        UIApplication.shared.presentLocalNotificationNow(notification)

        /* This method called because
        
        beaconRegion.notifyOnEntry = true
        
        in setupBeacon() function
        */

        
    }

    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        
        // Tells the delegate that the user exit the iBeacon range or area.
        
      //  simpleAlert("Thank You", message: "Visit Again")
         self.tag = ""
        self.tblBcon.reloadData()
        
        /* This method called because
        
        beaconRegion.notifyOnExit = true
        
        in setupBeacon() function
        */

    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        
        switch  state {
            
        case .inside:
            //The user is inside the iBeacon range.
            
            
            locationManager.startRangingBeacons(in: region as! CLBeaconRegion)

            break
            
        case .outside:
            //The user is outside the iBeacon range.
            locationManager.stopRangingBeacons(in: region as! CLBeaconRegion)
            
            break
            
        default :
            // it is unknown whether the user is inside or outside of the iBeacon range.
            break
            
        }
    }

    
    

    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion)
    {
        // Tells the delegate that one or more beacons are in range.
       let foundBeacons = beacons
        
        if foundBeacons.count > 0 {
            
            if let closestBeacon = foundBeacons[0] as? CLBeacon {
                    
                    var proximityMessage: String!
                if lastStage != closestBeacon.proximity {
                
                    lastStage = closestBeacon.proximity
                    
                    switch  lastStage {
                        
                    case .immediate:
                        proximityMessage = "Very close"
                        self.view.backgroundColor = UIColor.green
                         self.tag = region.identifier
                        
                    case .near:
                        proximityMessage = "Near"
                        self.view.backgroundColor = UIColor.gray
                         self.tag = region.identifier
                        
                    case .far:
                        proximityMessage = "Far"
                        self.view.backgroundColor = UIColor.black
                         self.tag = region.identifier
                        
                        
                    default:
                        proximityMessage = "Exit"
                        self.view.backgroundColor = UIColor.red
                        
                    }
                    var makeString = "Beacon Details:\n"
//                    makeString += "UUID = \(closestBeacon.proximityUUID.uuidString)\n"
//                    makeString += "Identifier = \( )\n"
//                    makeString += "Major Value = \(closestBeacon.major.int32Value)\n"
//                    makeString += "Minor Value = \(closestBeacon.minor.int32Value)\n"
                    makeString += "Distance From iBeacon = \(proximityMessage!)"

                   
                    self.beaconStatus.text = makeString
                   self.distance = proximityMessage
                    self.tblBcon.reloadData()
              }
            }
        }
    }

 }
    
