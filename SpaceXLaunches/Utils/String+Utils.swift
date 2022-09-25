//
//  String+Utils.swift
//  SpaceXLaunches
//
//  Created by Shajir Kalady on 9/25/22.
//

import Foundation

extension String {
    func getDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: self)
    }
}
