//
//  RequestManager.swift
//  
//
//  Created by macOS on 11.01.2019.
//

import UIKit
import Alamofire

private let headers = ["Content-Type": "application/x-www-form-urlencoded"]

class RequestManager: NSObject {
    
    static let sharedInstance = RequestManager()
    
    func getUsers (success: @escaping (_ responseUsers: [RLMUser]) -> Void,
                   failure: @escaping (_ errorCode: Int?) -> Void) {
        let url = "\(APIURL)\(USERS)"
        get(request: url, parameters: [:], success: { response in
            success(RLMUser.map(array: response))
        }) { errorCode in
            failure(errorCode)
        }
    }
    
    func createUser (firstName : String,
                     lastName : String,
                     email : String,
                     image_url : String,
                     success: @escaping (_ responseObject: Dictionary<String,Any>) -> Void,
                     failure: @escaping (_ errorCode: Int?) -> Void) {
        let url = "\(APIURL)\(USERS)"
        let parameters = ["user" : ["first_name" : firstName,
                                    "last_name" : lastName,
                                    "email" : email,
                                    "image_url" : image_url]]
        post(request: url, parameters: parameters, success: { response in
            print("\(response)")
        }) { errorCode in
            print("\(errorCode)")
        }
        
    }
    
    func updateUser (success: @escaping (_ responseObject: Dictionary<String,Any>) -> Void,
                     failure: @escaping (_ errorCode: Int?) -> Void) {
        let url = "\(APIURL)\(USERS)"
    }

}

extension RequestManager {
    private func get (request : String , parameters: [AnyHashable: Any], success: @escaping (_ responseObject: Array<Any>) -> Void, failure: @escaping (_ error: Int?) -> Void) {
        Alamofire.request(request, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                if let array = response.result.value as? [[String: Any]] {
                    print(array)
                    success(array)
                }
                break
            case .failure(_):
                failure(response.response?.statusCode)
                print(response.result.error!)
                break
            }
        }
    }
    
    private func post (request : String , parameters: [String: Any], success: @escaping (_ responseObject: Array<Any>) -> Void, failure: @escaping (_ error: Int?) -> Void) {
        Alamofire.request(request, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                if let array = response.result.value as? [[String: Any]] {
                    print(array)
                    success(array)
                }
                break
            case .failure(_):
                failure(response.response?.statusCode)
                print(response.result.error!)
                break
            }
        }
    }

    
//    private func delete (request : String , parameters: [String: Any], success: @escaping (_ responseObject: Dictionary<String, Any>) -> Void, failure: @escaping (_ error: Int?) -> Void) {
//        Alamofire.request(request, method: .delete, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
//            switch(response.result) {
//            case .success(_):
//                success(response.result.value! as! Dictionary<String, Any>)
//                print(response.result.value!)
//                break
//            case .failure(_):
//                failure(response.response?.statusCode)
//                print(response.result.error!)
//                break
//                
//            }
//        }
//    }
//    
//    private func put (request : String , parameters: [String: Any], success: @escaping (_ responseObject: Dictionary<String, Any>) -> Void, failure: @escaping (_ error: Int?) -> Void) {
//        Alamofire.request(request, method: .put, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
//            switch(response.result) {
//            case .success(_):
//                success(response.result.value! as! Dictionary<String, Any>)
//                print(response.result.value!)
//                break
//            case .failure(_):
//                failure(response.response?.statusCode)
//                print(response.result.error!)
//                break
//                
//            }
//        }
//    }
//    
//    private func post (request : String , parameters: [String: Any], success: @escaping (_ responseObject: Dictionary<String, Any>) -> Void, failure: @escaping (_ error: Int?) -> Void) {
//
//        Alamofire.request(request, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
//            switch(response.result) {
//            case .success(_):
//                success(response.result.value! as! Dictionary<String, Any>)
//                print(response.result.value!)
//                break
//            case .failure(_):
//                failure(response.response?.statusCode)
//                print(response.result.error!)
//                break
//                
//            }
//        }
//    }
}
