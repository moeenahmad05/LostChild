//
//  AllListRoot.swift
//  MyLostChild
//
//  Created by apple on 4/28/18.
//  Copyright © 2018 Moeen Ahmad. All rights reserved.
//

import Foundation

struct AllListRoot{
    
    var allData : [AllListData]!
    var message : String!
    var status : Bool!
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        allData = [AllListData]()
        if let allDataArray = dictionary["all_data"] as? [[String:Any]]{
            for dic in allDataArray{
                let value = AllListData(fromDictionary: dic)
                allData.append(value)
            }
        }
        message = dictionary["message"] as? String
        status = dictionary["status"] as? Bool
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if allData != nil{
            var dictionaryElements = [[String:Any]]()
            for allDataElement in allData {
                dictionaryElements.append(allDataElement.toDictionary())
            }
            dictionary["all_data"] = dictionaryElements
        }
        if message != nil{
            dictionary["message"] = message
        }
        if status != nil{
            dictionary["status"] = status
        }
        return dictionary
    }
    
}
