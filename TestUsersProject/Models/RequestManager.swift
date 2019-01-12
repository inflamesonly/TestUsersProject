//
//  RequestManager.swift
//  
//
//  Created by macOS on 11.01.2019.
//


//Почему ваш сервер при обновлении или создании юзера отдает весь список юзеров, если же адекватней возвращать обьект сохраненного(обновленного) юзера?И почему на обновление юзера используеться POST? Потому я и сделал так что у метода getImage свой гет запрос. Со всеми серверами что я работал всегда обьекты заворчивались в поля (к примеру "data"). И еще одно, к примеру я создал юзера, отправил на сервер - и сервер мне прислал 200 - но в списке юзера так и не стало, так же и апдейт - делаю апдейт именни юзеру с айдишником 2, сервер присылает 200 но апйдейта не случилось.


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
    
    func getImagesFromServer (success: @escaping (_ responseImages: [Image]) -> Void,
                   failure: @escaping (_ errorCode: Int?) -> Void) {
        let url = "\(IMAGESAPIURL)\(IMAGES)"
        getImages(request: url, parameters: [:], success: { response in
            success(Image.map(array: response["images"] as! Array<Any>))
        }) { errorCode in
            
        }

    }
    
    func createUser (firstName : String,
                     lastName : String,
                     email : String,
                     image_url : String,
                     success: @escaping (_ responseObject: Bool) -> Void,
                     failure: @escaping (_ errorCode: Int?) -> Void) {
        let url = "\(APIURL)\(USERS)"
        let parameters = ["user" : ["first_name" : firstName,
                                    "last_name" : lastName,
                                    "email" : email,
                                    "image_url" : image_url]]
        post(request: url, parameters: parameters, success: { response in
            success(true)
        }) { errorCode in
            failure(errorCode)
        }
    }
    
    func updateUser (id : String,
                     firstName : String,
                     lastName : String,
                     email : String,
                     image_url : String,
                     success: @escaping (_ responseObject: Bool) -> Void,
                     failure: @escaping (_ errorCode: Int?) -> Void) {
        let url = "\(APIURL)\(USERS)?user_id=\(id)"
        let parameters = ["user" : ["first_name" : firstName,
                                    "last_name" : lastName,
                                    "email" : email,
                                    "image_url" : image_url]]
        post(request: url, parameters: parameters, success: { response in
            success(true)
        }) { errorCode in
            failure(errorCode)
        }
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
    
    private func getImages (request : String , parameters: [AnyHashable: Any], success: @escaping (_ responseObject: Dictionary <String, Any>) -> Void, failure: @escaping (_ error: Int?) -> Void) {
        Alamofire.request(request, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                success(response.result.value! as! Dictionary<String, Any>)
                break
            case .failure(_):
                failure(response.response?.statusCode)
                print(response.result.error!)
                break
            }
        }
    }
}
