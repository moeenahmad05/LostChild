//
//  UserHandler.swift
//  MyLostChild
//
//  Created by apple on 4/28/18.
//  Copyright © 2018 Moeen Ahmad. All rights reserved.
//

import Foundation
import Alamofire
class UserHandler {
    
        static let sharedInstance = UserHandler()
    
    
    class func registerUser(param: NSDictionary, success: @escaping(RegisterRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.registerUser
        print(url)
        NetworkHandler.postRequest(url: url, parameters: param as! Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objUser = RegisterRoot(fromDictionary: dictionary)
            success(objUser)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    
    class func loginUser(param: NSDictionary, success: @escaping(LoginRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.loginUser
        print(url)
        NetworkHandler.postRequest(url: url, parameters: param as! Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objUser = LoginRoot(fromDictionary: dictionary)
            success(objUser)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func forgotPassword(param: NSDictionary, success: @escaping(ForgotPassword)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.forgotPassword
        print(url)
        NetworkHandler.postRequest(url: url, parameters: param as! Parameters, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objUser = ForgotPassword(fromDictionary: dictionary)
            success(objUser)
        }) { (error) in
             failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
    
    class func allListData(success: @escaping(AllListRoot)-> Void, failure: @escaping(NetworkError)-> Void) {
        let url = Constants.URL.baseUrl+Constants.URL.allList
        print(url)
        NetworkHandler.getRequest(url: url, parameters: nil, success: { (successResponse) in
            let dictionary = successResponse as! [String: Any]
            let objData = AllListRoot(fromDictionary: dictionary)
            success(objData)
        }) { (error) in
            failure(NetworkError(status: Constants.NetworkError.generic, message: error.message))
        }
    }
}
