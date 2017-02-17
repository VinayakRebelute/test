//
//  constants.swift
//  RetailApp swift
//
//  Created by Ajinkya's on 31/03/15.
//  Copyright (c) 2015 Ajinkya. All rights reserved.
//

import UIKit


//MARK: - -------------------- ALL Extension --------------------------- -


//MARK: - ------ App In Background ----- -

extension DispatchQueue {
    
    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }
    
}
//MARK: - ------ side Animation ----- -
extension UIView {
    // Name this function in a way that makes sense to you...
    // slideFromLeft, slideRight, slideLeftToRight, etc. are great alternative names
    func slideInFromLeft(_ duration: TimeInterval = 0.5, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromLeftTransition.delegate = delegate as? CAAnimationDelegate
        }
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = kCATransitionPush
        slideInFromLeftTransition.subtype = kCATransitionFromLeft
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        slideInFromLeftTransition.fillMode = kCAFillModeRemoved
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
    
    
    func slideInFromRight(_ duration: TimeInterval = 0.5, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            slideInFromLeftTransition.delegate = delegate as? CAAnimationDelegate
        }
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = kCATransitionPush
        slideInFromLeftTransition.subtype = kCATransitionFromRight
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        slideInFromLeftTransition.fillMode = kCAFillModeRemoved
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
    
}



//MARK: - ------ Text Field check foe empty ----- -



extension String {
    func isEmptyOrWhitespace() -> Bool {
        
        if(self.isEmpty) {
            return true
        }
        
        return (self.trimmingCharacters(in: CharacterSet.whitespaces) == "")
    }
    
    
    func aesEncrypt() -> String{
        let data = self.data(using: String.Encoding.utf8)
        let base64String: String = data!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0));
        let result = String(base64String)
        return result!
    }
    
    
}


//MARK: - ------ ADD IMAGE TO NAVIGATION CONTROLLER ----- -


extension UIViewController
{
    
    public func defaultNavigationImage()
    {
        let nav = self.navigationController
        
        nav?.isNavigationBarHidden  = false
        
        nav?.navigationBar.barTintColor = UIColor(red: 239.0 / 255.0, green: 84.0 / 255.0, blue: 68.0 / 255.0, alpha: 1.0)
        
        nav?.navigationBar.isTranslucent = false
        
        let logo = UIImage(named: "Rebelute_Logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        self.navigationItem.titleView?.center = imageView.center
    }
}

//MARK: - ------ ADD BORDER FOR ANY VIEW ----- -

extension UIView {
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set(newValue) {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set(newValue) {
            layer.borderColor = newValue?.cgColor
        }
    }
}


//MARK: - ------ TABLE VIEW CELL ANIMATION ----- -


extension UIViewController
{
    func animateTable(_ tableName:UITableView)
    {
        tableName.reloadData()
        
        let cells = tableName.visibleCells
        let tableHeight: CGFloat = tableName.bounds.size.height
        
        for i in cells
        {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for a in cells
        {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animate(withDuration: 2.0, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations:
                {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0);
                }, completion: nil)
            
            index += 1
        }
    }
}


//MARK: - ------ Check device type ----- -


public extension UIDevice
{
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1":                               return "iPhone 7"
    
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
}


let delegate = UIApplication.shared.delegate as! AppDelegate



class constants: NSObject,UIAlertViewDelegate
{
    //MARK: -----------Base URL-----------
    
    
    
    
    //   Live App Url
    let baseUrl : NSString = "http://54.208.126.92/coupons/home_coupon" // snpposasc
    
    
    
    
    //MARK: ----------- Register Device Token -----------
    
    let RegisterDeviceToken : NSString = "http://54.208.126.92/coupons/home_coupon/registerDevice"
    
    
    
    //MARK: ----------- get Servey Questions Options-----------
    
    let getServeyQuestionsOptions : NSString = "/getServeyQuestionsOptions"
    

    //MARK: ----------- get Coupon Detail-----------
    
    let getCouponDetail : NSString = "/getCouponDetail"
    
    
    //MARK: ----------- get Beacon Related Coupon -----------
    
    let getBeaconRelatedCoupon : NSString = "/getBeaconRelatedCoupon"
    
    
    
    
    
    
    
    
    
    
    //MARK: ----------- check Social Already Registered -----------
    
    let checkSocialAlreadyRegistered
        : NSString = "checkSocialAlreadyRegistered"
    
    
    //MARK: ----------- Login Request Member-----------
    
    let userLoginService : NSString = "login_user"
    
    
    //MARK: ----------- check Valid Email For Forgot Password -----------
    
    let checkValidEmailForForgotPassword : NSString = "getForgotPasswordKey"
    
    
    //MARK: ----------- validate Password Key -----------
    
     let ValidatePasswordKey : NSString = "validatePasswordKey"

    
    
    //MARK: ----------- set New Password For The User -----------
    
    let setNewPasswordForTheUser : NSString = "setNewUserForgotPassword"
    
    
    //MARK: ----------- SendMail  -----------
    
     let SendMail : NSString = "saveUserInfoAndMail"
    
    
    
    
    
    
    
    
    
    //MARK: ----------- saveContactInformation  -----------
    
    let saveContactInformation : NSString = "http://rebelute.com/webservices/saveContactInformation"
    
    //MARK: ----------- Blogs -----------
    
    let getAllCategories : NSString = "http://rebelute.com/webservices/getAllCategories"
    
    
     let BlogList : NSString = "http://rebelute.com/webservices/getBlogList"

    let BaseUrlForBlogImage : String = "http://rebelute.com/uploads/blogs/"
    
    let BlogDetails : NSString = "http://rebelute.com/webservices/getSingleBlogDetail"


   

    
    
    
    
    
    
    
    
    
    
    
    
        
    

    let storyBord : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    //MARK: -----------Alert Method-----------
    
    func showAlertWithTitleAndMesssage(_ title:NSString,msg:NSString)
    {
//        let alert = UIAlertView(title: title as String, message: msg as String, delegate: self, cancelButtonTitle: "Ok")
//        
//        alert .show()
    }
    
    
    //MARK: ----------- Validation Methods -----------

    
    func isValidEmail(_ YourEmailAddress: String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+\\.[A-Za-z]{2,16}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: YourEmailAddress)
    }
    
    func isValidPassword(_ YourPassword: String) -> Bool
    {
        let passwordRegEx = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{6,16}$"
        
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: YourPassword)
    }
    
    //MARK: -----------Web service Call Method-----------
    
    
   
    
    
    func PerformRequestwith(_ url:NSString,strparam:NSString,methodUsed:NSString,WithCompletion:@escaping (_ data : Data?,_ ErrorType : String?,_ errorMessage : String?) -> ())
    {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        //        let req : NSMutableURLRequest = NSMutableURLRequest (url: URL(string: url as String)!)
        var req : URLRequest = URLRequest(url: URL(string: url as String)!)
        req.httpMethod = methodUsed as String
        req.timeoutInterval = 30
        
        if(methodUsed.isEqual(to: "POST")==true)
        {
            req.httpBody = strparam.data(using: String.Encoding.utf8.rawValue)
        }
        
        else
        {
            
        }
        let dataTask = session.dataTask(with: req, completionHandler:
            {
                (returnData: Data?, response: URLResponse?, error: Error?) -> Void in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3)
                { () -> Void in
                    if error != nil
                    {
                        if error?._code ==  -1009
                        {
                            print("The Internet connection appears to be offline.")
                            let msg = "The Internet connection appears to be offline."
                            let title = "No Internet"
                            WithCompletion(returnData, title, msg)
                        }
                        if error?._code ==  NSURLErrorTimedOut
                        {
                            print("Time Out")
                            
                            
                            let msg = "Connection time out please try again"
                            let title = "Connection Time"
                            
                            WithCompletion(returnData, title, msg)
                        }
                    }
                    else
                    {
                        WithCompletion(returnData, "nil", "nil")
                    }
                }
        })
        
        dataTask.resume()
    }
    
    func PerformRequestBackGroundwith(_ url:NSString,strparam:NSString,methodUsed:NSString,WithCompletion:@escaping (_ data : Data?,_ ErrorType : String?,_ errorMessage : String?) -> ())
    {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        //        let req : NSMutableURLRequest = NSMutableURLRequest (url: URL(string: url as String)!)
        var req : URLRequest = URLRequest(url: URL(string: url as String)!)
        req.httpMethod = methodUsed as String
        req.timeoutInterval = 30
        
        if(methodUsed.isEqual(to: "POST")==true)
        {
            req.httpBody = strparam.data(using: String.Encoding.utf8.rawValue)
        }
            
        else
        {
            
        }
      DispatchQueue.global(qos: .background).async {
        
        let dataTask = session.dataTask(with: req, completionHandler:
            {
                (returnData: Data?, response: URLResponse?, error: Error?) -> Void in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3)
                { () -> Void in
                    if error != nil
                    {
                        if error?._code ==  -1009
                        {
                            print("The Internet connection appears to be offline.")
                            let msg = "The Internet connection appears to be offline."
                            let title = "No Internet"
                            WithCompletion(returnData, title, msg)
                        }
                        if error?._code ==  NSURLErrorTimedOut
                        {
                            print("Time Out")
                            
                            
                            let msg = "Connection time out please try again"
                            let title = "Connection Time"
                            
                            WithCompletion(returnData, title, msg)
                        }
                    }
                    else
                    {
                        WithCompletion(returnData, "nil", "nil")
                    }
                }
        })
        
        dataTask.resume()
        }
    }

    
    //MARK: -----------Web service image send to server  Method-----------
    func PerformRequestwithImage(_ url:NSString,strparam:[String:AnyObject],imagedata : Data,methodUsed:NSString,WithCompletion:@escaping (_ data : Data?,_ ErrorType : String?,_ errorMessage : String?) -> ())
    {
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        //   let req : NSMutableURLRequest = NSMutableURLRequest (url: URL(string: url as String)!)
        
        var req : URLRequest = URLRequest(url: URL(string: url as String)!)
        
        req.httpMethod = "POST"
        req.timeoutInterval = 60
        let boundary = NSString(format: "---------------------------14737809831466499882746641449")
        let contentType = NSString(format: "multipart/form-data; boundary=%@",boundary)
        req.addValue(contentType as String, forHTTPHeaderField: "Content-Type")
        
        let body:NSMutableData = NSMutableData()
        
        
        
        // Image
        body.append(NSString(format: "\r\n--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
        body.append(NSString(format:"Content-Disposition: form-data; name=\"profile_image\"; filename=\"user_pic123.jpg\"\\r\n").data(using: String.Encoding.utf8.rawValue)!)
        body.append(NSString(format: "Content-Type: application/octet-stream\r\n\r\n").data(using: String.Encoding.utf8.rawValue)!)
        body.append(imagedata)
        body.append(NSString(format: "\r\n--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
        
        // Video
        
        //    let mimetype = "video/mov"
        
        //        body.appendData(NSString(format: "\r\n--%@\r\n", boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
        //        body.appendData(NSString(format:"Content-Disposition: form-data; name=\"video\"; filename=\"video.3gp\"\\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        //        body.appendData(NSString(format: "Content-Type: video/3gp\r\n\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        //        body.appendData(videoData!)
        //        body.appendData(NSString(format: "\r\n--%@\r\n", boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
        
        for (key, value) in strparam {
            
            body.append(NSString(format: "--\(boundary)\r\n" as NSString, boundary).data(using: String.Encoding.utf8.rawValue)!)
            body.append(NSString(format: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n" as NSString, boundary).data(using: String.Encoding.utf8.rawValue)!)
            body.append(NSString(format: "\(value)\r\n" as NSString, boundary).data(using: String.Encoding.utf8.rawValue)!)
        }
        
        
        //        if(methodUsed.isEqualToString("POST")==true)
        //        {
        //            req.HTTPBody = strparam.dataUsingEncoding(NSUTF8StringEncoding)
        //        }
        req.httpBody = body as Data
        
        let dataTask = session.dataTask(with: req, completionHandler:
            {
                (returnData: Data?, response: URLResponse?, error: Error?) -> Void in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3)
                { () -> Void in
                    if error != nil
                    {
                        if error?._code ==  -1009
                        {
                            print("The Internet connection appears to be offline.")
                            let msg = "The Internet connection appears to be offline."
                            let title = "No Internet"
                            WithCompletion(returnData, title, msg)
                        }
                        if error?._code ==  NSURLErrorTimedOut
                        {
                            print("Time Out")
                            
                            
                            let msg = "Connection time out please try again"
                            let title = "Connection Time"
                            
                            WithCompletion(returnData, title, msg)
                        }
                    }
                    else
                    {
                        WithCompletion(returnData, "nil", "nil")
                    }
                }
        })
        
        dataTask.resume()
        
        
        
        
        
    }
    
    
    
    
    
    //MARK: -----------Web service Contact image  send to server  Method-----------
    func PerformRequestwithContactImage(_ url:NSString,strparam:[String:AnyObject],imagedata : Data,methodUsed:NSString,WithCompletion:@escaping (_ data : Data?,_ ErrorType : String?,_ errorMessage : String?) -> ())
    {
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        //  let req : NSMutableURLRequest = NSMutableURLRequest (url: URL(string: url as String)!)
        var req : URLRequest = URLRequest(url: URL(string: url as String)!)
        
        req.httpMethod = "POST"
        req.timeoutInterval = 60
        let boundary = NSString(format: "---------------------------14737809831466499882746641449")
        let contentType = NSString(format: "multipart/form-data; boundary=%@",boundary)
        req.addValue(contentType as String, forHTTPHeaderField: "Content-Type")
        
        
        
        let body:NSMutableData = NSMutableData()
        
        let mimetype = "image/png"
        
        // Image
        body.append(NSString(format: "\r\n--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
        //  body.appendData("Content-Type: \(mimetype)\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.append(NSString(format:"Content-Disposition: form-data; name=\"contact_image\"; filename=\"user_pic.png\"\\r\n").data(using: String.Encoding.utf8.rawValue)!)
        body.append(NSString(format: "Content-Type: \(mimetype)\r\n\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
        body.append(imagedata)
        body.append(NSString(format: "\r\n--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
        
        // Video
        
        //    let mimetype = "video/mov"
        
        //        body.appendData(NSString(format: "\r\n--%@\r\n", boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
        //        body.appendData(NSString(format:"Content-Disposition: form-data; name=\"video\"; filename=\"video.3gp\"\\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        //        body.appendData(NSString(format: "Content-Type: video/3gp\r\n\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        //        body.appendData(videoData!)
        //        body.appendData(NSString(format: "\r\n--%@\r\n", boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
        
        for (key, value) in strparam {
            
            body.append(NSString(format: "--\(boundary)\r\n" as NSString, boundary).data(using: String.Encoding.utf8.rawValue)!)
            body.append(NSString(format: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n" as NSString, boundary).data(using: String.Encoding.utf8.rawValue)!)
            body.append(NSString(format: "\(value)\r\n" as NSString, boundary).data(using: String.Encoding.utf8.rawValue)!)
        }
        
        
        //        if(methodUsed.isEqualToString("POST")==true)
        //        {
        //            req.HTTPBody = strparam.dataUsingEncoding(NSUTF8StringEncoding)
        //        }
        req.httpBody = body as Data
        
        let dataTask = session.dataTask(with: req, completionHandler:
            {
                (returnData: Data?, response: URLResponse?, error: Error?) -> Void in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3)
                { () -> Void in
                    if error != nil
                    {
                        if error?._code ==  -1009
                        {
                            print("The Internet connection appears to be offline.")
                            let msg = "The Internet connection appears to be offline."
                            let title = "No Internet"
                            WithCompletion(returnData, title, msg)
                        }
                        if error?._code ==  NSURLErrorTimedOut
                        {
                            print("Time Out")
                            
                            
                            let msg = "Connection time out please try again"
                            let title = "Connection Time"
                            
                            WithCompletion(returnData, title, msg)
                        }
                    }
                    else
                    {
                        WithCompletion(returnData, "nil", "nil")
                    }
                }
        })
        
        dataTask.resume()
        
    }
    
}
