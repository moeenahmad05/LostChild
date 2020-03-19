//
//  LoginRoot.swift
//  MyLostChild
//
//  Created by apple on 4/28/18.
//  Copyright © 2018 Moeen Ahmad. All rights reserved.
//

import Foundation

struct LoginRoot{
    
    var message : String!
    var status : Bool!
    var userData : LoginData!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        message = dictionary["message"] as? String
        status = dictionary["status"] as? Bool
        if let userDataData = dictionary["user_data"] as? [String:Any]{
            userData = LoginData(fromDictionary: userDataData)
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if message != nil{
            dictionary["message"] = message
        }
        if status != nil{
            dictionary["status"] = status
        }
        if userData != nil{
            dictionary["user_data"] = userData.toDictionary()
        }
        return dictionary
    }
    
}
