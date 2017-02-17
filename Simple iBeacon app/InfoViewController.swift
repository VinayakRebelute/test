//
//  InfoViewController.swift
//  Simple iBeacon app
//
//  Created by Paritosh Sharma on 19/01/17.
//  Copyright © 2017 Alphanso Tech. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
