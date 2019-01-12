//
//  Image.swift
//  TestUsersProject
//
//  Created by macOS on 12.01.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

import UIKit

struct Image {
    let imageURL: String
    
    init(imageURL : String) {
        self.imageURL = imageURL
    }
    
    init(response : Dictionary <String, Any>) {
        self.imageURL = response["url"] as? String ?? ""
    }
    
    static func map (array : Array<Any>) -> [Image]{
        var images = [Image]()
        for dic in array {
            let image = Image(response: dic as! Dictionary<String, Any>)
            images.append(image)
        }
        return images
    }
}
