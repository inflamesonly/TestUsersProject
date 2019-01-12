//
//  CurrentDateFormatExt.swift
//  RssTestProject
//
//  Created by macOS on 09.01.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

import UIKit

extension String {
    func convertDateFromNeedFormat () -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-DD HH:mm:ss"
        
        let dateObj = dateFormatter.date(from: self)
        
        dateFormatter.dateFormat = "MMM d, yyyy HH:mm"
        return dateFormatter.string(from: dateObj!)
    }
    
    func convertCurrentDateFromNeedFormat () -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMM d, yyyy HH:mm"
        return dateFormatter.string(from: date)
    }

}
