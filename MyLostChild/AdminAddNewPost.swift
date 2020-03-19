//
//  AdminAddNewPost.swift
//  MyLostChild
//
//  Created by Fatoora GCC on 4/25/18.
//  Copyright © 2018 Moeen Ahmad. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class AdminAddNewPost: UITableViewController , UINavigationControllerDelegate, UIImagePickerControllerDelegate,MKMapViewDelegate, CLLocationManagerDelegate,UITextFieldDelegate{

    @IBOutlet weak var segmentcontrol: UISegmentedControl!
    @IBOutlet weak var updatelocation: MKMapView!
    var selectedImage : UIImage?
    var gender = "Male"
    var imageURL: NSURL!
    var fileName: String!
    
    @IBOutlet weak var fname: UITextField!
   
    @IBOutlet weak var lname: UITextField!
    
    @IBOutlet weak var age: UITextField!
    
    let newPin = MKPointAnnotation()
    let locationManager =  CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        imagePicker.delegate = self

        
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
    
    
    
    
    
    @IBAction func actionSegment(_ sender: UISegmentedControl) {
        if segmentcontrol.selectedSegmentIndex == 0 {
            gender = "Male"
        }
        else if segmentcontrol.selectedSegmentIndex == 1 {
            gender = "Female"
        }
    }
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var chooseBuuton: UIButton!
    var imagePicker = UIImagePickerController()
    
    
    @IBAction func upLoadImageBtnPressed(_ sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        
        /*
         The sourceType property wants a value of the enum named        UIImagePickerControllerSourceType, which gives 3 options:
         
         UIImagePickerControllerSourceType.PhotoLibrary
         UIImagePickerControllerSourceType.Camera
         UIImagePickerControllerSourceType.SavedPhotosAlbum
         
         */
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
            selectedImage = pickedImage
            // You can change your image name here, i use NSURL image and convert into string
             imageURL = info[UIImagePickerControllerReferenceURL] as! NSURL
            fileName = imageURL.absoluteString
            
        }
        
        
        /*
         
         Swift Dictionary named “info”.
         We have to unpack it from there with a key asking for what media information we want.
         We just want the image, so that is what we ask for.  For reference, the available options are:
         
         UIImagePickerControllerMediaType
         UIImagePickerControllerOriginalImage
         UIImagePickerControllerEditedImage
         UIImagePickerControllerCropRect
         UIImagePickerControllerMediaURL
         UIImagePickerControllerReferenceURL
         UIImagePickerControllerMediaMetadata
         
         */
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion:nil)
    }
    
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let location = locations.last as! CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.updatelocation.setRegion(region, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBOutlet weak var txtDescription: UITextView!
    
    
    @IBAction func actionSubmit(_ sender: Any) {
        
        guard let fName = fname.text else {
            return
        }
        
        guard let lname = lname.text else {
            return
        }
        guard let age = age.text else {
            return
        }
        
        if fName == "" {
            let alert = UIAlertController(title: "Error", message: "Please enter the First Name", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if lname == "" {
            let alert = UIAlertController(title: "Error", message: "Please enter the email id", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        else if age == "" {
            let alert = UIAlertController(title: "Error", message: "Please enter the mobile no ", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        else {
        let url = URL(string: "http://34.213.24.77/reem/api/post_child.php")!
        
        let params: [String: String] = ["f_name": fName,"l_name": lname, "age": age, "gender": gender, "user_id": fName, "time": lname]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<600).responseJSON() { response in
            
            switch response.result {
            case .success:
                
                _ = [String:String]()
                
                if response.result.value != nil {
                    
                    print(response.result.value)
                    UserDefaults.standard.set(true, forKey: "LoggedIn")
                    
                    
                    let alert = UIAlertController(title: "Sucess!", message: "you are sucessfully added Missing Child to server. It will show to all user whenever they login now", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
            case .failure(let error):
                print("RESPONSE ERROR: \(error)")
                
                
                
            }
            }
        
        }
        
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
