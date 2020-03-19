//
//  AllListData.swift
//  MyLostChild
//
//  Created by apple on 4/28/18.
//  Copyright © 2018 Moeen Ahmad. All rights reserved.
//

import Foundation

struct AllListData{
    
    var age : String!
    var dateTime : String!
    var descriptionField : String!
    var fName : String!
    var gender : String!
    var image : String!
    var imagePath : String!
    var lName : String!
    var location : String!
    var missingDateTime : String!
    var missingId : String!
    var status : String!
    var userId : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        age = dictionary["age"] as? String
        dateTime = dictionary["date_time"] as? String
        descriptionField = dictionary["description"] as? String
        fName = dictionary["f_name"] as? String
        gender = dictionary["gender"] as? String
        image = dictionary["image"] as? String
        imagePath = dictionary["image_path"] as? String
        lName = dictionary["l_name"] as? String
        location = dictionary["location"] as? String
        missingDateTime = dictionary["missing_date_time"] as? String
        missingId = dictionary["missing_id"] as? String
        status = dictionary["status"] as? String
        userId = dictionary["user_id"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if age != nil{
            dictionary["age"] = age
        }
        if dateTime != nil{
            dictionary["date_time"] = dateTime
        }
        if descriptionField != nil{
            dictionary["description"] = descriptionField
        }
        if fName != nil{
            dictionary["f_name"] = fName
        }
        if gender != nil{
            dictionary["gender"] = gender
        }
        if image != nil{
            dictionary["image"] = image
        }
        if imagePath != nil{
            dictionary["image_path"] = imagePath
        }
        if lName != nil{
            dictionary["l_name"] = lName
        }
        if location != nil{
            dictionary["location"] = location
        }
        if missingDateTime != nil{
            dictionary["missing_date_time"] = missingDateTime
        }
        if missingId != nil{
            dictionary["missing_id"] = missingId
        }
        if status != nil{
            dictionary["status"] = status
        }
        if userId != nil{
            dictionary["user_id"] = userId
        }
        return dictionary
    }
    
}
