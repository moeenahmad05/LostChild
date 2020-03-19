//
//  UserListingMissingChild.swift
//  MyLostChild
//
//  Created by Fatoora GCC on 4/25/18.
//  Copyright © 2018 Moeen Ahmad. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SDWebImage
class UserListingMissingChild: UIViewController, UITableViewDelegate, UITableViewDataSource, NVActivityIndicatorViewable  {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tableFooterView = UIView()
            let nib = UINib(nibName: "MissingChildCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "missingchild")
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MissingChildCell = tableView.dequeueReusableCell(withIdentifier: "missingchild", for: indexPath) as! MissingChildCell
        let objData = dataArray[indexPath.row]
        if let name = objData.fName {
            if let lastName = objData.lName {
                
                cell.name.text = "\(name) \(lastName)"
            }
        }
        if let age = objData.age {
            cell.age.text = "Age: \(age) Yrs"
        }
        if let address = objData.location {
            cell.adress.text = address
        }
        if let imgUrl = URL(string: objData.image) {
            cell.childimage.sd_setImage(with: imgUrl, completed: nil)
        }
        cell.morebutton.addTarget(self, action: #selector(self.btnAction(_:)), for: .touchUpInside)
        
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
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem

        
    }
    
    func btnAction(_ sender: UIButton) {
        let otherAlert = UIAlertController(title: "Report", message: "Please report the missing child in order to get there family. ", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let printSomething = UIAlertAction(title: "Last seen ", style: UIAlertActionStyle.default) { _ in
            
            
            print("We can run a block of code." )
            
           
   
         //   self.performSegue(withIdentifier: "lastseen", sender: self)
            
            
        }
        let lastseen = UIAlertAction(title: "Report To Police", style: UIAlertActionStyle.default) { _ in
            
            
            print("We can run a block of code." )
            
            
              self.performSegue(withIdentifier: "reportpolice", sender: self)
            
        }
        
        
        
        let dismiss = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        // relate actions to controllers
        otherAlert.addAction(printSomething)
        otherAlert.addAction(lastseen)
        otherAlert.addAction(dismiss)
        
        present(otherAlert, animated: true, completion: nil)
        
    }

    
    
    @IBAction func more(_ sender: Any) {
        
       
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
