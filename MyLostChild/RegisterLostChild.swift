//
//  RegisterLostChild.swift
//  MyLostChild
//
//  Created by Fatoora GCC on 4/25/18.
//  Copyright © 2018 Moeen Ahmad. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Alamofire

class RegisterLostChild: UITableViewController, NVActivityIndicatorViewable {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtLastname: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var adress: UITextField!
    
    @IBOutlet weak var btnSignUpDown: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "Back-Arrow.png")
        
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Back-Arrow.png")
        
    }
    
    @IBAction func actionSignUp(_ sender: UIButton) {
        guard let fName = txtName.text else {
            return
        }
       
        guard let password = txtPassword.text else {
            return
        }
        guard let confirmPassword = txtConfirmPassword.text else {
            return
        }
        guard let email = txtEmail.text else {
            return
        }
        guard let number = txtNumber.text else {
            return
        }
        guard let adressf = adress.text else {
            return
        }
        
        if fName == "" {
            let alert = UIAlertController(title: "Error", message: "Please enter the First Name", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if email == "" {
            let alert = UIAlertController(title: "Error", message: "Please enter the email id", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        else if number == "" {
            let alert = UIAlertController(title: "Error", message: "Please enter the mobile no ", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        else if adressf == "" {
            
            let alert = UIAlertController(title: "Error", message: "Please enter the adress", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if password == "" {
            let alert = UIAlertController(title: "Error", message: "Please enter the password", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if confirmPassword == "" {
            let alert = UIAlertController(title: "Error", message: "Please enter the Confirm Password", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if password != confirmPassword {
            let alert = UIAlertController(title: "Error", message: "your password did't match", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
            
        else {
           
            let url = URL(string: "http://34.213.24.77/reem/api/register.php")!
            
            let params: [String: String] = ["name": fName, "email": email, "password": password, "phone": number, "city": adressf]
            
            Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                
                switch response.result {
                case .success:
                    
                    _ = [String:String]()
                    
                    if response.result.value != nil {
                        
                        print(response.result.value)
                        UserDefaults.standard.set(true, forKey: "LoggedIn")
                        
                        
                         self.performSegue(withIdentifier: "Register", sender: self)
                        
                        let alert = UIAlertController(title: "Sucess!", message: "you are sucessfully registered as a user", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    
                case .failure(let error):
                    print("RESPONSE ERROR: \(error)")
                    
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    
    //MARK: - Custom
    func showLoader(){
        self.startAnimating(Constants.activitySize.size, message: Constants.loaderMessages.loadingMessage.rawValue,messageFont: UIFont.systemFont(ofSize: 14), type: NVActivityIndicatorType.ballClipRotatePulse)
    }
    
    
    
    //MARK:- API Call
    
    func registerUser(parameter: NSDictionary) {
        self.showLoader()
        UserHandler.registerUser(param: parameter, success: { (successResponse) in
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
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
