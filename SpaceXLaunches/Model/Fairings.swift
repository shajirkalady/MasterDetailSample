//
//  Fairings.swift
//  SpaceXLaunches
//
//  Created by Shajir Kalady on 9/23/22.
//

import Foundation

struct Fairings: Codable{
    var reused: Bool? = nil
    var recoveryAttempt: Bool? = nil
    var recovered: Bool? = nil
    var ship: String? = nil
}
