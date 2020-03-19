//
//  AdminListing.swift
//  MyLostChild
//
//  Created by Fatoora GCC on 4/25/18.
//  Copyright © 2018 Moeen Ahmad. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


class AdminListing: UIViewController , UITableViewDelegate, UITableViewDataSource , NVActivityIndicatorViewable {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tableFooterView = UIView()
            let nib = UINib(nibName: "adminlistcell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "adminchildlist")
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: adminlistcell = tableView.dequeueReusableCell(withIdentifier: "adminchildlist", for: indexPath) as! adminlistcell
        let objData = dataArray[indexPath.row]
        
        
        if let name = objData.fName {
            if let lastName = objData.lName {
                cell.lblName.text = "\(name) \(lastName)"
            }
        }
        
        if let age = objData.age {
            cell.lblAge.text = "Age: \(age) Yrs"
        }
        if let address = objData.location {
            cell.lblAddress.text = address
        }
        if let imgUrl = URL(string: objData.image) {
            cell.imgPicture.sd_setImage(with: imgUrl, completed: nil)
        }
        
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.allData()
    }

    @IBAction func Logout(_ sender: Any) {
        
        let otherAlert = UIAlertController(title: "Logout", message: "Are you sure you want to logout as a Admin?", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let printSomething = UIAlertAction(title: "YES", style: UIAlertActionStyle.default) { _ in
            
            
            print("We can run a block of code." )
            
            
             UserDefaults.standard.removeObject(forKey: "AdminLoggedIn")
            
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - Custom
    func showLoader(){
        self.startAnimating(Constants.activitySize.size, message: Constants.loaderMessages.loadingMessage.rawValue,messageFont: UIFont.systemFont(ofSize: 14), type: NVActivityIndicatorType.ballClipRotatePulse)
    }
    var dataArray = [AllListData]()
    
    //MARK:- API Call
    func allData() {
        self.showLoader()
        UserHandler.allListData(success: { (successResponse) in
            self.stopAnimating()
            if successResponse.status {
                self.dataArray = successResponse.allData
                self.tableView.reloadData()
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
