//
//  SurveyViewController.swift
//  Simple iBeacon app
//
//  Created by Paritosh Sharma on 09/01/17.
//  Copyright © 2017 Alphanso Tech. All rights reserved.
//

import UIKit

class SurveyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    @IBOutlet weak var vwQuestion: UIView!
    
    @IBOutlet weak var lblQuestion: UILabel!

    
    @IBOutlet weak var tblAns: UITableView!
    
    @IBOutlet weak var btnPrivious: UIButton!
    
    @IBOutlet weak var btnNext: UIButton!
    
    
    let constant = constants()
    var activityIndicatorView: ActivityIndicatorView!

    
    var PriviousRow  = -1
    
    var arrSelectAns : NSMutableArray = NSMutableArray()
    var arrNoQuestion : NSMutableArray = NSMutableArray()

    var QuestionNo = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
         PUSH_NOTIFICATION_FLAG = false

        
          self.activityIndicatorView = ActivityIndicatorView(title: "Processing...", center: self.view.center)
//        let filePath : NSString = Bundle.main.path(forResource: "countrycodes", ofType: "json")! as NSString
//        
//        let data : NSData = NSData .dataWithContentsOfMappedFile(filePath as String) as! NSData
//        // arrPlans = NSArray()
//        let   arr = (try! JSONSerialization.jsonObject(with: data as Data, options: [])) as! NSArray
//        
//        
//        arrNoQuestion = NSMutableArray(array: arr)
//
//        self.QuestionNo = 0
//        if self.arrNoQuestion.count == 1
//        {
//            self.btnPrivious.isHidden = true
//            self.btnNext.isHidden = true
//        }
//        else
//        {
//            self.btnPrivious.isHidden = true
//            self.btnNext.isHidden = false
//        }
//        self.CreateBlog(tag: QuestionNo)

        tblAns.rowHeight = UITableViewAutomaticDimension
        tblAns.estimatedRowHeight = 140
        
        self.WebSeviceGetAllQuestions()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func CreateBlog(tag : Int)
    {
        let dic = arrNoQuestion.object(at: tag) as! NSDictionary
        lblQuestion.text = dic.value(forKey: "question") as? String
            
            //dic.value(forKey: "Question") as? String
        
        tblAns.reloadData()
        
//        lblCategory.text = dic.value(forKey: "category") as? String
//        lblPostedBy.text = dic.value(forKey: "posted_by") as? String
//        lblTitle.text = dic.value(forKey: "title") as? String
//        strShortDis = (dic.value(forKey: "mobile_description") as? String)!
//        
//        //   let htmlString:String! = "<br /><h2>Welcome to SourceFreeze!!!</h2>"
//        webView.loadHTMLString(strShortDis, baseURL: nil)
//        
//        var imgUrl = constant.BaseUrlForBlogImage +  (dic.value(forKey: "blog_image") as! String)
//        imgUrl = imgUrl.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!
//        let url = URL(string: imgUrl)!
//        
//        self.ActivityIndicator.isHidden = true
//        self.ActivityIndicator.startAnimating()
//        imgBlog.kf_setImage(with: url,
//                            placeholder: nil,
//                            options: [.transition(ImageTransition.fade(1))],
//                            progressBlock: { receivedSize, totalSize in
//                                print(" \(receivedSize)/\(totalSize)")
//        },
//                            completionHandler: { image, error, cacheType, imageURL in
//                                
//                                self.imgBlog.image = image
//                                self.ActivityIndicator.stopAnimating()
//                                
//                                print(":Finished")
//        })
//        
//        
//        
        
    }

    //MARK:-   ------------Table View Data Source -------------------
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if arrNoQuestion.count != 0
        {
            let dic = arrNoQuestion.object(at: QuestionNo) as! NSDictionary
            let arr = dic.value(forKey: "options") as! NSArray
            return arr.count
        }
        else
        {
            return 0
        }
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : TableViewCell = tableView.dequeueReusableCell(withIdentifier: "SurveyCellId", for: indexPath) as! TableViewCell
        
        
        if indexPath.section%2 == 0
        {
             cell.vwBackground.backgroundColor = UIColor(red: 230/255, green: 231/255, blue: 232/255, alpha: 1.0)
        }
       else
        {
             cell.vwBackground.backgroundColor = UIColor(red: 209/255, green: 211/255, blue: 212/255, alpha: 1.0)
        }
        let dic = arrNoQuestion.object(at: QuestionNo) as! NSDictionary
        let arr = dic.value(forKey: "options") as! NSArray
        let dicAns = arr.object(at: indexPath.section) as! NSDictionary

        
        cell.lblAns.text = dicAns.value(forKey: "option_value") as? String
        
        cell.btnCheck.tag = indexPath.section
        if arrSelectAns.count != 0
        {
            if arrSelectAns.object(at: 0) as! Int == indexPath.section
            {
                cell.btnCheck.isSelected = true
            }
            else
            {
                cell.btnCheck.isSelected = false
            }
            
        }
        else
        {
            cell.btnCheck.isSelected = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
    {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        
        return view
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        if  UIDevice.current.userInterfaceIdiom == .phone
        {
            return 8
        }
        else
        {
            return 20
        }
    }

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
         if arrSelectAns.count != 0
         {
            if arrSelectAns.object(at: 0) as! Int == indexPath.section
            {
                arrSelectAns.removeAllObjects()
            }
            else
            {
                arrSelectAns.replaceObject(at: 0, with: indexPath.section)

            }
        }
        else
         {
            arrSelectAns.insert(indexPath.section, at: 0)
        }
        
        
        tblAns.reloadData()
        
//        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
//        
//        let PriviousIndexPath = NSIndexPath(row: PriviousRow, section: 0)
//       
//        
//        if indexPath != PriviousIndexPath as IndexPath
//        {
//            if PriviousRow != -1
//            {
//                let PriviousCell = tableView.cellForRow(at: PriviousIndexPath as IndexPath) as! TableViewCell
//                
//                PriviousCell.btnCheck.isSelected = false
//                
//            }
//            
//            
//            
//            if  cell.btnCheck.isSelected == false
//            {
//                cell.btnCheck.isSelected = true
//                
//            }
//            else
//            {
//                cell.btnCheck.isSelected = false
//            }
//            
//            PriviousRow = indexPath.row
//        }
//        else
//        {
//            if  cell.btnCheck.isSelected == false
//            {
//                cell.btnCheck.isSelected = true
//                
//            }
//            else
//            {
//                cell.btnCheck.isSelected = false
//            }
//        }
    }
    
    
    
    @IBAction func btnCheckBoxClicked(_ sender: UIButton)
    {
        if arrSelectAns.count != 0
        {
            arrSelectAns.replaceObject(at: 0, with: sender.tag)
        }
        else
        {
            arrSelectAns.insert(sender.tag, at: 0)
        }
        
        
        tblAns.reloadData()
        
    }
    
    @IBAction func btnPriviousClicked(_ sender: Any)
    {
        if QuestionNo == 1
        {
            btnPrivious.isHidden = true
            vwQuestion.slideInFromLeft()
            QuestionNo -= 1
            self.CreateBlog(tag: QuestionNo)
            btnNext.isHidden = false
            
            
        }
        else
        {
        
          //  btnNext.isHidden = false
             btnNext.setTitle("NEXT", for: .normal)
            vwQuestion.slideInFromLeft()
            QuestionNo -= 1
            self.CreateBlog(tag: QuestionNo)
        }


        self.arrSelectAns.removeAllObjects()
    }
    
    
    @IBAction func btnNextClicked(_ sender: Any)
    {
        
        if btnNext.titleLabel?.text == "SUBMIT"
            {
                UserDefaults.standard.set("1", forKey: "CouponComes")
                  let dic = arrNoQuestion.object(at: 0) as? NSDictionary
                MY_COUPON_ID = (dic?.value(forKey: "coupon_id") as? String)!
             _ = self.navigationController?.popViewController(animated: true)

             // dismiss(animated: true, completion: nil)
        }
        else
        {
            if arrNoQuestion.count - 2 == QuestionNo {
                
                vwQuestion.slideInFromRight()
                QuestionNo += 1
                self.CreateBlog(tag: QuestionNo)
                btnNext.setTitle("SUBMIT", for: .normal)
            }
            else
            {
                vwQuestion.slideInFromRight()
                QuestionNo += 1
                self.CreateBlog(tag: QuestionNo)
                
            }
            if QuestionNo >= 0
            {
                btnPrivious.isHidden = false
            }
            
            self.arrSelectAns.removeAllObjects()
        }
       


    }
    
    
    @IBAction func btnLogoutClicked(_ sender: Any) {
        _ =  self.navigationController?.popToRootViewController(animated: true)

//        let presentingViewController = self.presentingViewController
//        self.dismiss(animated: false, completion: {
//            presentingViewController!.dismiss(animated: true, completion: {})
//        })
    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)

        //dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    func WebSeviceGetAllQuestions()
    {
        
        var urlStr : NSString = NSString(format:"%@%@",constant.baseUrl,constant.getServeyQuestionsOptions)
        urlStr = urlStr.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
        
        self.view.addSubview(self.activityIndicatorView.getViewActivityIndicator())
        activityIndicatorView.startAnimating()
        // var user_id = UserDefaults.standard.value(forKey: "user_id") as! String
               
      
        
        
        
        // let company_id = UserDefaults.standard.value(forKey: "company_id") as! String
        
       let str : NSString = NSString(format: "survey_id=%@",MY_SURVEY_ID)
        
        //user_id
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
                            let arr  = d.value(forKey: "data") as? NSArray
                            
                            
                              self.arrNoQuestion = NSMutableArray(array: arr!)

                            self.QuestionNo = 0
                            if self.arrNoQuestion.count == 1
                            {
                                self.btnPrivious.isHidden = true
                                self.btnNext.isHidden = true
                            }
                            else
                            {
                                self.btnPrivious.isHidden = true
                                self.btnNext.isHidden = false
                            }
                            self.CreateBlog(tag: self.QuestionNo)

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

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
