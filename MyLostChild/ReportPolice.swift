//
//  ReportPolice.swift
//  MyLostChild
//
//  Created by Fatoora GCC on 4/25/18.
//  Copyright © 2018 Moeen Ahmad. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class ReportPolice: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate,MKMapViewDelegate, CLLocationManagerDelegate,UITextFieldDelegate{

   @IBOutlet weak var updatelocation: MKMapView!
    
    @IBOutlet weak var currentlocationt: UITextField!
    @IBOutlet weak var seenvalue: UIDatePicker!
    @IBOutlet weak var descriptionva: UITextView!
    
    let newPin = MKPointAnnotation()
    let locationManager =  CLLocationManager()

  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        UIApplication.shared.statusBarStyle = .lightContent
        
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "Back-Arrow.png")
        
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Back-Arrow.png")
        
       
     
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if #available(iOS 8.0, *) {
            locationManager.requestAlwaysAuthorization()
        } else {
            // Fallback on earlier versions
        }
        locationManager.startUpdatingLocation()
        
        
        
    }
    
    func mapLongPress(_ recognizer: UIGestureRecognizer) {
        
        print("A long press has been detected.")
        
        let touchedAt = recognizer.location(in: self.updatelocation) // adds the location on the view it was pressed
        let touchedAtCoordinate : CLLocationCoordinate2D = updatelocation.convert(touchedAt, toCoordinateFrom: self.updatelocation) // will get coordinates
        
        let newPin = MKPointAnnotation()
        newPin.coordinate = touchedAtCoordinate
        updatelocation.addAnnotation(newPin)
        
        
    }
    
func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        updatelocation.removeAnnotation(newPin)
        
        let location = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        //set region on the map
        updatelocation.setRegion(region, animated: true)
        
        newPin.coordinate = location.coordinate
        updatelocation.addAnnotation(newPin)
        
    }
    
    @IBAction func updatetoserver(_ sender: Any) {
        
      
       
        
            
                
                let url = URL(string: "http://34.213.24.77/reem/api/report_police.php")!
                
                let lattitude = "34.0000"
                let longitude = "68.0000"
                let missingidvalue = "Test001"
                let situationdesc = descriptionva.text
                let seentime =  ""
                
                
                let params: [String: String] = ["latitude": lattitude, "longitude": longitude , "address": situationdesc!  ]
                
                Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
                    
                    switch response.result {
                    case .success:
                        
                        _ = [String:String]()
                        
                        if response.result.value != nil {
                            
                            print(response.result.value)
                            
                            let alert = UIAlertController(title: "Sucess", message: "You have sucessfully updated missing Child , our Team gonna look for the adresss you mentioned stay connected we will contact you son for further more information  ", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            
                            
                            
                            
                        }
                        
                    case .failure(let error):
                        print("RESPONSE ERROR: \(error)")
                        
                        let alert = UIAlertController(title: "No Internet Connection", message: "Check your network settings and try again.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        
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
