//
//  ViewController.swift
//  Simple iBeacon app
//
//  Created by Alphanso Tech on 14/12/15.
//  Copyright © 2015 Alphanso Tech. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth
import Kingfisher

class ViewController: UIViewController,CBPeripheralManagerDelegate,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var beaconStatus: UILabel!
    @IBOutlet weak var tblBcon: UITableView!
   

    
    
    @IBOutlet weak var vwbeconPopUp: UIView!
    
    @IBOutlet weak var lblExpireDate: UILabel!
    @IBOutlet weak var imgCoupon: UIImageView!
    @IBOutlet weak var actController: UIActivityIndicatorView!
    @IBOutlet weak var lblCouponTitle: UILabel!
    
    @IBOutlet weak var lblCouponDes: UILabel!
    @IBOutlet weak var lblStorePrice: UILabel!
    @IBOutlet weak var lblOfferPrice: UILabel!
    
    let locationManager = CLLocationManager()
    let myBTManager = CBPeripheralManager()
    var lastStage = CLProximity.unknown
    
    
    var BeaconName = ["Blueberry","Ice","Mint"]
    var BeaconId = ["B9407F30-F5F8-466E-AFF9-25556B57FE6D","B9407F30-F5F8-466E-AFF9-25556B57FE6D","B9407F30-F5F8-466E-AFF9-25556B57FE6D"]
    var BeaconMajor = ["55380","4463","12311"]
    var BeaconMinor = ["46539","9556","64064"]
    
    
    var tag  = ""
    var distance = ""

    let constant = constants()
    var activityIndicatorView: ActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

        self.activityIndicatorView = ActivityIndicatorView(title: "Processing...", center: self.view.center)
        if PUSH_NOTIFICATION_FLAG == true
        {
          ///   self.performSegue(withIdentifier: "SurveySegue", sender: self)
        }
        else
        {
            self.setupBeacon()

        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
       // UserDefaults.standard.set("1", forKey: "CouponComes")

        if PUSH_NOTIFICATION_FLAG == true
        {
            self.performSegue(withIdentifier: "SurveySegue", sender: self)
        }
        else
        {
            if UserDefaults.standard.value(forKey: "CouponComes") != nil
            {
                if UserDefaults.standard.value(forKey: "CouponComes") as! String == "1"   {
                    
                    self.WebSeviceGetCouponwithID()

                    
//                     if UserDefaults.standard.value(forKey: "RegionID") != nil                      {
//
////                        if UserDefaults.standard.value(forKey: "RegionID") as! String != ""
////                        {
////                         // self.WebSeviceGetCouponWithRegion()
////
////                        }
////                        else
////                        {
////                            self.WebSeviceGetCouponwithID()
////                            
////                        }
//
//
//                    }
//                    else
//                     {
//                        self.WebSeviceGetCouponwithID()
//
//                    }
                   

                    
                   
                }
            }            
        }
      
       
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        
//        if peripheral.state == CBPeripheralManagerState.poweredOff {
//            
//            simpleAlert("Beacon", message: "Turn On Your Device Bluetooh")
//        }
        
        print("Checking")
        switch(peripheral.state)
        {
        case.unsupported:
            print("BLE is not supported")
        case.unauthorized:
            print("BLE is unauthorized")
        case.unknown:
            print("BLE is Unknown")
        case.resetting:
            print("BLE is Resetting")
        case.poweredOff:
            print("BLE service is powered off")
            simpleAlert("Beacon", message: "Turn On Your Device Bluetooh")
        case.poweredOn:
            print("BLE service is powered on")
            print("Start Scanning")
           // myBTManager.scanForPeripheralsWithServices(nil, options: nil)
        default:
            print("default state")
        }
        
        
        
    }
    /// Ui table view Method
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : TableViewCell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! TableViewCell
        
        cell.beconName.text = BeaconName[indexPath.row]

        cell.bconId.text = BeaconId[indexPath.row]
        cell.lblMajor.text = BeaconMajor[indexPath.row]
        cell.lblMinor.text = BeaconMinor[indexPath.row]

        if cell.beconName.text == self.tag
        {
         
                 cell.beconStatus.text = "INSIDE"
           
           
            cell.lblDistance.text = distance
        }
        else
        {
            cell.beconStatus.text = "OUTSIDE"
             cell.lblDistance.text = "N/A"
        }

        
        return cell
    }
    
    
    
    
    
    @IBAction func btnLogoutClicked(_ sender: Any) {
        _ =  self.navigationController?.popToRootViewController(animated: true)
        
       // dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnStartSurveyClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "SurveySegue", sender: self)
    }
    
    
    @IBAction func btnMyCouponClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "MyCouponSegue", sender: self)

        
    }
    
    @IBAction func btnGetCouponClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "MyCouponSegue", sender: self)

    }
    @IBAction func btnHelpClicked(_ sender: Any)
    {
        self.performSegue(withIdentifier: "HelpSegue", sender: self)

    }
    
    
    
    @IBAction func btnAvailOfferClicked(_ sender: Any) {
        
        UserDefaults.standard.set("0", forKey: "CouponComes")
        UserDefaults.standard.set("", forKey: "RegionID")
        MY_COUPON_ID = ""


         self.vwbeconPopUp.isHidden =  true
    }
    
    @IBAction func closePopUpClicled(_ sender: Any) {
        UserDefaults.standard.set("0", forKey: "CouponComes")
        UserDefaults.standard.set("", forKey: "RegionID")
        MY_COUPON_ID = ""


        self.vwbeconPopUp.isHidden =  true
    }
    
    
    func ShowCoupon(dict : NSDictionary)  {
        self.lblCouponTitle.text = dict.value(forKey: "coupon_name") as? String
        self.lblCouponDes.text = dict.value(forKey: "description") as? String
        self.lblExpireDate.text = "Expires : " + (dict.value(forKey: "valid_till") as? String)!
        self.lblStorePrice.text = "In Store : $" + (dict.value(forKey: "normal_price") as? String)!
        self.lblOfferPrice.text = "Genie Price : $" + (dict.value(forKey: "discounted_price") as? String)!
        vwbeconPopUp.isHidden = false

        var imgUrl = dict.value(forKey: "image") as? String
        imgUrl = imgUrl?.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!
        let url = URL(string: imgUrl!)!
        
        actController.isHidden = false
        actController.startAnimating()
        imgCoupon.kf.setImage(with: url,
                                    placeholder: nil,
                                    options: nil,
                                    progressBlock: { receivedSize, totalSize in
                                        print(" \(receivedSize)/\(totalSize)")
        },
                                    completionHandler: { image, error, cacheType, imageURL in
                                        
                                       self.imgCoupon.image = image
                                       self.actController.stopAnimating()
                                        
                                        print(":Finished")
        })
    }
    
    
    
    func WebSeviceGetCouponwithID()
    {
        
        var urlStr : NSString = NSString(format:"%@%@",constant.baseUrl,constant.getCouponDetail)
        urlStr = urlStr.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
        
        self.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())
        activityIndicatorView.startAnimating()
        //MY_COUPON_ID
        
         let str : NSString = NSString(format: "coupon_id=%@",MY_COUPON_ID)
        
        //
        constant.PerformRequestwith(urlStr, strparam: str,methodUsed:"POST")
        { (data,errorType,errorMEssage) -> () in
            self.activityIndicatorView.stopAnimating()
            
            if (data != nil)
            {
                
                do {
                    
                    let dict: AnyObject? = try JSONSerialization.jsonObject(with: data!, options: []) as AnyObject?
                    if (dict?.isKind(of: NSDictionary.self) == true)
                    {
                        let d : NSDictionary = dict as! NSDictionary
                        
                        
                        
                        if d.value(forKey: "status") as! Bool == true
                        {
                            let dic  = d.value(forKey: "data") as? NSDictionary
                            
                            
                            self.ShowCoupon(dict: dic!)
                            
                            // value(forKey: "UserInfo") as! NSMutableDictionary
                            
                            // UserDefaults.standard.value(forKey: "")
                            //  dic.setValue( "name", forKey: "name")
                            
                            //                            UserDefaults.standard.set(dic, forKey: "UserInfo")
                            //
                            //                            let alertViewController = UIAlertController(title: "Success", message: d.value(forKey: "message") as? String, preferredStyle: .alert)
                            //
                            //                            let okAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                            //                                //     dic = UserDefaults.standard.value(forKey: "UserInfo") as! NSMutableDictionary
                            //                                //  print("Update value : \(dic.value(forKey: "name"))")
                            //                            }
                            //
                            //
                            //
                            //                            alertViewController.addAction(okAction)
                            //
                            //                            self.present(alertViewController, animated: true, completion: nil)
                            //
                            
                            
                            // let maindict  = dict?.value(forKey: "main_data") as! NSDictionary
                            
                            // let total_invoice_amount : Int = maindict.value(forKey: "total_invoice_amount") as! Int
                            
                            
                            
                            
                            
                        }
                            
                        else
                        {
                            let alertViewController = UIAlertController(title: "Error", message: d.value(forKey: "message") as? String, preferredStyle: .alert)
                            
                            let okAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                            }
                            
                            
                            
                            alertViewController.addAction(okAction)
                            
                            self.present(alertViewController, animated: true, completion: nil)
                        }
                    }
                    
                    
                    
                    
                } catch _ {
                    
                    print("Error")
                    let alertController = UIAlertController(title: "Error", message: "Please try again", preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                    }))
                    self.present(alertController, animated: true, completion: nil)
                    
                    
                    
                }
                
                
                
            }
                
                
            else
                
            {
                let alertController = UIAlertController(title: errorType, message: errorMEssage, preferredStyle: .alert)
                
                
                
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                
                
                
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }

    
  /*  func WebSeviceGetCouponWithRegion()
    {
        
        var urlStr : NSString = NSString(format:"%@%@",constant.baseUrl,constant.getBeaconRelatedCoupon)
        urlStr = urlStr.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
        
        self.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())
        activityIndicatorView.startAnimating()
        
        let region = UserDefaults.standard.value(forKey: "RegionID") as! String
        let str : NSString = NSString(format: "beacon=%@",region)
        
        //
        constant.PerformRequestwith(urlStr, strparam: str,methodUsed:"POST")
        { (data,errorType,errorMEssage) -> () in
            self.activityIndicatorView.stopAnimating()
            
            if (data != nil)
            {
                
                do {
                    
                    let dict: AnyObject? = try JSONSerialization.jsonObject(with: data!, options: []) as AnyObject?
                    if (dict?.isKind(of: NSDictionary.self) == true)
                    {
                        let d : NSDictionary = dict as! NSDictionary
                        
                        
                        
                        if d.value(forKey: "status") as! Bool == true
                        {
                            let dic  = d.value(forKey: "data") as? NSDictionary
                            
                            
                            self.ShowCoupon(dict: dic!)
                            // value(forKey: "UserInfo") as! NSMutableDictionary
                            
                            // UserDefaults.standard.value(forKey: "")
                            //  dic.setValue( "name", forKey: "name")
                            
                            //                            UserDefaults.standard.set(dic, forKey: "UserInfo")
                            //
                            //                            let alertViewController = UIAlertController(title: "Success", message: d.value(forKey: "message") as? String, preferredStyle: .alert)
                            //
                            //                            let okAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                            //                                //     dic = UserDefaults.standard.value(forKey: "UserInfo") as! NSMutableDictionary
                            //                                //  print("Update value : \(dic.value(forKey: "name"))")
                            //                            }
                            //
                            //
                            //
                            //                            alertViewController.addAction(okAction)
                            //
                            //                            self.present(alertViewController, animated: true, completion: nil)
                            //
                            
                            
                            // let maindict  = dict?.value(forKey: "main_data") as! NSDictionary
                            
                            // let total_invoice_amount : Int = maindict.value(forKey: "total_invoice_amount") as! Int
                            
                            
                            
                            
                            
                        }
                            
                        else
                        {
                            let alertViewController = UIAlertController(title: "Error", message: d.value(forKey: "message") as? String, preferredStyle: .alert)
                            
                            let okAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                            }
                            
                            
                            
                            alertViewController.addAction(okAction)
                            
                            self.present(alertViewController, animated: true, completion: nil)
                        }
                    }
                    
                    
                    
                    
                } catch _ {
                    
                    print("Error")
                    let alertController = UIAlertController(title: "Error", message: "Please try again", preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                        
                    }))
                    self.present(alertController, animated: true, completion: nil)
                    
                    
                    
                }
                
                
                
            }
                
                
            else
                
            {
                let alertController = UIAlertController(title: errorType, message: errorMEssage, preferredStyle: .alert)
                
                
                
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                    
                }))
                
                
                
                
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }

    */
    
}
