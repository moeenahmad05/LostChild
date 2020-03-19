//
//  LostChildForget.swift
//  MyLostChild
//
//  Created by Fatoora GCC on 4/24/18.
//  Copyright © 2018 Moeen Ahmad. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Alamofire

class LostChildForget: UIViewController, NVActivityIndicatorViewable {

    
    @IBOutlet weak var txtEmail: UITextField!
    
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
    
    
    
    @IBAction func actionSubmit(_ sender: Any) {
        
        guard let email = txtEmail.text else {
            return
        }
        
        if email == "" {
            let alert = Constants.showBasicAlert(message: "Write you email Address")
            self.present(alert, animated: true, completion: nil)
        }
        else {
            self.showLoader()
            let url = URL(string: "http://34.213.24.77/reem/api/forgot_password.php")!
            
            let params: [String: String] = ["email": email]
            
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                self.stopAnimating()
                
                switch response.result {
                case .success:
                    
                    _ = [String:String]()
                    
                    if response.result.value != nil {
                        
                      //  print(response.result.value)
                        
                        let alert = UIAlertController(title: "Sucess!", message: "we have sucessfully send email to registered mail id go and check email and use the password to login ", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Thanks", style: UIAlertActionStyle.default, handler: nil))
                    }
                    
                case .failure(let error):
                    print("RESPONSE ERROR: \(error)")
                    
                }
                
            }
        }
        
    }
    
    func forgotPassword(param: NSDictionary) {
        self.showLoader()
        UserHandler.forgotPassword(param: param, success: { (successResponse) in
            self.stopAnimating()
            if successResponse.status {
                let alert = Constants.showBasicAlert(message: successResponse.message)
                self.present(alert, animated: true, completion: nil)
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
    
    
    

}
