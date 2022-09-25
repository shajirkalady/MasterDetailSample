//
//  Date+Utils.swift
//  SpaceXLaunches
//
//  Created by Shajir Kalady on 9/23/22.
//

import Foundation

extension Date {
    func string() -> String  {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MMM dd HH:mm EEEE"
        return dateFormatter.string(from: self)
    }
}
