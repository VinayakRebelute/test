//
//  LoginViewController.swift
//  Simple iBeacon app
//
//  Created by Paritosh Sharma on 09/01/17.
//  Copyright © 2017 Alphanso Tech. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    
    
    var activityIndicatorView: ActivityIndicatorView!
       var constant = constants()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true
        if PUSH_NOTIFICATION_FLAG == true
        {
            self.performSegue(withIdentifier: "HomeSegue", sender: self)
        }
        txtEmail.leftView = UIView(frame: CGRect(x: 35, y: 0, width: 30, height: 35))
        txtEmail.leftViewMode = .always
        
        txtPassword.leftView = UIView(frame: CGRect(x: 35, y: 0, width: 30, height: 35))
        txtPassword.leftViewMode = .always
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtEmail
        {
            txtPassword.becomeFirstResponder()
        }
      else  if  textField == txtPassword
        {
            txtPassword.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func btnLoginClicked(_ sender: Any)
    {
        if txtEmail.text?.isEmptyOrWhitespace() == true
        {
            let alert = UIAlertController(title: "", message: "Please Enter Email-ID", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: {(action) -> Void in
            })
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
        }
        else if txtPassword.text?.isEmptyOrWhitespace() == true{
            let alert = UIAlertController(title: "", message: "Please Enter Password", preferredStyle: .alert)
            
            let alertaction = UIAlertAction(title: "OK", style: .cancel, handler: {(action) -> Void in
            })
            alert.addAction(alertaction)
            self.present(alert, animated: true, completion: nil)
        }
        else if constant.isValidEmail(txtEmail.text!) == false
        {
            let alert = UIAlertController(title: "", message: "Enter valid Email-ID", preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: {(action) -> Void in
            })
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
        }
        
        else
        {
            self.performSegue(withIdentifier: "HomeSegue", sender: self)
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
