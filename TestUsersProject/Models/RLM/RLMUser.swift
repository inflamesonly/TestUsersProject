//
//  RLMUser.swift
//  TestUsersProject
//
//  Created by macOS on 11.01.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

import UIKit
import RealmSwift

class RLMUser: Object {
    @objc dynamic var uiid = UUID().uuidString
    @objc dynamic var id = 0
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var email = ""
    @objc dynamic var imageUrl = ""
    @objc dynamic var createdDate = ""
    @objc dynamic var updatedDate = ""
    
    override static func primaryKey() -> String? {
        return "uiid"
    }
    
    convenience init(response : Dictionary<String, Any>) {
        self.init()
        self.id = response ["id"] as? Int ?? 0
        self.firstName = response ["first_name"] as? String ?? ""
        self.lastName = response ["last_name"] as? String ?? ""
        self.email = response ["email"] as? String ?? ""
        self.imageUrl = response ["image_url"] as? String ?? ""
        self.createdDate = response ["created"] as? String ?? ""
        self.updatedDate = response ["updated"] as? String ?? ""
    }
    
    func user (id : Int) -> RLMUser {
        let myPrimaryKey = "\(id)"
        let realm = try! Realm()
        let user = realm.object(ofType: RLMUser.self, forPrimaryKey: myPrimaryKey)
        return user!
    }
    
    func update (id : Int, updateUser : RLMUser) {
        let user = self.user(id: id)
        let realm = try! Realm()
        try! realm.write {

        }
    }
    
    static func map (array : Array<Any>) -> [RLMUser]{
        var users = [RLMUser]()
        for dic in array {
            let user = RLMUser(response: dic as! Dictionary<String, Any>)
            users.append(user)
        }
        return users
    }
    
}
