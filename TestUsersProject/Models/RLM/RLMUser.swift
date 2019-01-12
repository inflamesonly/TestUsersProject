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
    @objc dynamic var id = ""
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
        self.id = response ["id"] as? String ?? ""
        self.firstName = response ["first_name"] as? String ?? ""
        self.lastName = response ["last_name"] as? String ?? ""
        self.email = response ["email"] as? String ?? ""
        self.imageUrl = response ["image_url"] as? String ?? ""
        self.createdDate = response ["created"] as? String ?? ""
        self.updatedDate = response ["updated"] as? String ?? ""
        self.uiid = self.id
        self.checkNeedDateFormat()
    }
    
    convenience init(firstName : String, lastName : String, email : String) {
        self.init()
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
    
    private func checkNeedDateFormat () {
        if self.createdDate != "0000-00-00 00:00:00" {
            self.createdDate = self.createdDate.convertDateFromNeedFormat()
        } else {
            self.createdDate = "Incorect date"
        }
        if self.updatedDate != "0000-00-00 00:00:00" {
            self.updatedDate = self.updatedDate.convertDateFromNeedFormat()
        } else {
            self.updatedDate = "Incorect date"
        }
    }
    
    func isfindUser (id : String) -> Bool {
        let myPrimaryKey = "\(id)"
        let realm = try! Realm()
        guard realm.object(ofType: RLMUser.self, forPrimaryKey: myPrimaryKey) != nil else {
            print("user not found!")
            return true
        }
        return false
    }
    
    func findUser (email : String) -> Bool {
        var userIsFind = false
        let realm = try! Realm()
        let usersObjets = realm.objects(RLMUser.self)
        for user in usersObjets {
            if user.email == email {
                userIsFind = true
                break
            }
        }
        return userIsFind
    }
    
    func get (id : String) -> RLMUser {
        let myPrimaryKey = "\(id)"
        let realm = try! Realm()
        return realm.object(ofType: RLMUser.self, forPrimaryKey: myPrimaryKey)!
    }
    
    func update (user : RLMUser) {
        let realm = try! Realm()
        let updatedUser = self.get(id: self.id)
        try! realm.write {
            updatedUser.firstName = user.firstName
            updatedUser.lastName = user.lastName
            updatedUser.email = user.email
            updatedUser.updatedDate = user.updatedDate.convertCurrentDateFromNeedFormat()
        }
    }
    
    static func getAllUsers () -> [RLMUser] {
        let realm = try! Realm()
        let users = realm.objects(RLMUser.self)
        return Array(users)
    }
    
    func save (user : RLMUser) {
        if self.isfindUser(id: user.id) {
            let realm = try! Realm()
            try! realm.write {
                realm.add(user)
            }
        }
    }
    
    static func map (array : Array<Any>) -> [RLMUser]{
        var users = [RLMUser]()
        for dic in array {
            let user = RLMUser(response: dic as! Dictionary<String, Any>)
            user.save(user: user)
            users.append(user)
        }
        return users
    }
    
}
