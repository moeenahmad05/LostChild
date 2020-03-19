//
//  LoginData.swift
//  MyLostChild
//
//  Created by apple on 4/28/18.
//  Copyright © 2018 Moeen Ahmad. All rights reserved.
//

import Foundation

struct LoginData{
    
    var address : String!
    var city : String!
    var email : String!
    var gender : String!
    var id : String!
    var lname : String!
    var name : String!
    var password : String!
    var phone : String!
    var province : String!
    var status : String!
    var type : String!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        address = dictionary["address"] as? String
        city = dictionary["city"] as? String
        email = dictionary["email"] as? String
        gender = dictionary["gender"] as? String
        id = dictionary["id"] as? String
        lname = dictionary["lname"] as? String
        name = dictionary["name"] as? String
        password = dictionary["password"] as? String
        phone = dictionary["phone"] as? String
        province = dictionary["province"] as? String
        status = dictionary["status"] as? String
        type = dictionary["type"] as? String
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if address != nil{
            dictionary["address"] = address
        }
        if city != nil{
            dictionary["city"] = city
        }
        if email != nil{
            dictionary["email"] = email
        }
        if gender != nil{
            dictionary["gender"] = gender
        }
        if id != nil{
            dictionary["id"] = id
        }
        if lname != nil{
            dictionary["lname"] = lname
        }
        if name != nil{
            dictionary["name"] = name
        }
        if password != nil{
            dictionary["password"] = password
        }
        if phone != nil{
            dictionary["phone"] = phone
        }
        if province != nil{
            dictionary["province"] = province
        }
        if status != nil{
            dictionary["status"] = status
        }
        if type != nil{
            dictionary["type"] = type
        }
        return dictionary
    }
    
}
