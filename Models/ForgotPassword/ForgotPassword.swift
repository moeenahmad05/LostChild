//
//  ForgotPassword.swift
//  MyLostChild
//
//  Created by apple on 4/28/18.
//  Copyright © 2018 Moeen Ahmad. All rights reserved.
//

import Foundation

struct ForgotPassword {
    
    var message : String!
    var result : String!
    var status : Bool!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        message = dictionary["message"] as? String
        result = dictionary["result"] as? String
        status = dictionary["status"] as? Bool
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
        if result != nil{
            dictionary["result"] = result
        }
        if status != nil{
            dictionary["status"] = status
        }
        return dictionary
    }
    
}
