//
//  Info.swift
//  MyLostChild
//
//  Created by Fatoora GCC on 4/25/18.
//  Copyright © 2018 Moeen Ahmad. All rights reserved.
//

import UIKit

 var window: UIWindow?

class Info: UIViewController , UIApplicationDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

 
    
   
    @IBAction func moreActionsButtonPressed(sender: UIButton) {
        let otherAlert = UIAlertController(title: "Logout", message: "Are you sure you want to logout as a user?", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let printSomething = UIAlertAction(title: "YES", style: UIAlertActionStyle.default) { _ in
           
            
            print("We can run a block of code." )
        
               UserDefaults.standard.removeObject(forKey: "LoggedIn")
          
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "LoginStart") as! UINavigationController
            self.present(controller, animated: true, completion: nil)
         
            
        }
        

        
        let dismiss = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        // relate actions to controllers
        otherAlert.addAction(printSomething)
       
        otherAlert.addAction(dismiss)
        
        present(otherAlert, animated: true, completion: nil)
    }
    
    func myHandler(alert: UIAlertAction){
        print("You tapped: \(String(describing: alert.title))")
    }
    
    @IBAction func watchvideo(_ sender: Any) {
        
        UIApplication.shared.openURL(NSURL(string: "https://www.youtube.com/watch?v=lEObID61KDo")! as URL)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
