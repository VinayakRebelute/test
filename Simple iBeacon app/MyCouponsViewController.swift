//
//  MyCouponsViewController.swift
//  Simple iBeacon app
//
//  Created by Paritosh Sharma on 13/01/17.
//  Copyright © 2017 Alphanso Tech. All rights reserved.
//

import UIKit

class MyCouponsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    
    var arrImage = ["Coupon1.png","Coupon2.png","Coupon3.png","Coupon4.png","Coupon5.png","Coupon6.png",]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    //MARK: - ------------ collection View Delegate method ------------ -
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCouponcellID", for: indexPath) as! MyCouponCollectionViewCell
        
        
        cell.imgCoupon.image = UIImage(named: arrImage[indexPath.item])
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
      
               
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\((indexPath as NSIndexPath).item)!")
        
        
     
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize
    {
        
        if  UIDevice.current.userInterfaceIdiom == .phone
        {
            return CGSize(width: (UIScreen.main.bounds.width)/2 - 1,height: 235);
        }
        else
        {
            return CGSize(width: (UIScreen.main.bounds.width)/3 - 1,height: 235);
        }

        
        //return CGSizeMake((UIScreen.mainScreen().bounds.width-10)/3,120)//use height whatever you wants.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! GuestDashboardViewCell
//        cell.viewHidden.isHidden = false
//        cell.backgroundColor = UIColor(red: 255/255, green:255/255, blue: 255/255, alpha: 0.01)
        
    }
    
    // change background color back when user releases touch
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! GuestDashboardViewCell
//        cell.viewHidden.isHidden = true
//        cell.backgroundColor = UIColor(red: 255/255, green:255/255, blue: 255/255, alpha: 0.1)
        
    }
    
    
    
    
    @IBAction func btnLogoutClicked(_ sender: Any) {
        
      _ =  self.navigationController?.popToRootViewController(animated: true)
//        let presentingViewController = self.presentingViewController
//        self.dismiss(animated: false, completion: {
//            presentingViewController!.dismiss(animated: true, completion: {})
//        })
    }

    

    @IBAction func BtnBackClicked(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)

      //  dismiss(animated: true, completion: nil)
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
