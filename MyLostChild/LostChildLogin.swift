//
//  LostChildLogin.swift
//  MyLostChild
//
//  Created by Fatoora GCC on 4/24/18.
//  Copyright © 2018 Moeen Ahmad. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Alamofire


class LostChildLogin: UIViewController , NVActivityIndicatorViewable{
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
        UIApplication.shared.statusBarStyle = .lightContent
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
    }
    
    @IBAction func onClickSignIn(_ sender: UIButton) {
        
        guard let email = txtEmail.text else {
            return
        }
        
        guard let password = txtPassword.text else {
            return
        }
        
        if email == "" {
     
            let alert = UIAlertController(title: "Error", message: "Please Fill Email id ", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
       
        else if password == "" {
            let alert = UIAlertController(title: "Error", message: "Please enter the password", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if password.characters.count < 6 {
            
            let alert = UIAlertController(title: "Error", message: "enter password more than 6 Character ", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
           
            
            if email == "admin@missingchild.com" && password == "12345678"
            
            {

            
                UserDefaults.standard.set(true, forKey: "AdminLoggedIn")

                self.performSegue(withIdentifier: "admin", sender: self)
 

            }
            else{
                
                let url = URL(string: "http://34.213.24.77/reem/api/login.php")!
                
                let params: [String: String] = ["email": email, "password": password]
                
                Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                    
                    switch response.result {
                    case .success:
                        
                        _ = [String:String]()
                        
                        if response.result.value != nil {
                            
                            print(response.result.value)
                            
                            UserDefaults.standard.set(true, forKey: "LoggedIn")
                            
                            
                         
                            self.performSegue(withIdentifier: "user", sender: self)
                            let alert = UIAlertController(title: "Sucess!", message: "you are sucessfully LoggedIn as a User", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                            
                        }
                        
                    case .failure(let error):
                        print("RESPONSE ERROR: \(error)")
                        
                    }
                    
                }
        

            }
            
        
        }
    }
    
   
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Custom
    func showLoader(){
        self.startAnimating(Constants.activitySize.size, message: Constants.loaderMessages.loadingMessage.rawValue,messageFont: UIFont.systemFont(ofSize: 14), type: NVActivityIndicatorType.ballClipRotatePulse)
    }
    
    
    func loginUser(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.loginUser(param: parameter, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.status {
                
            }
            else {
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
            }
        }) { (error) in
            self.stopAnimating()
            let alert = Constants.showBasicAlert(message: error.message)
            self.present(alert, animated: true, completion: nil)
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
