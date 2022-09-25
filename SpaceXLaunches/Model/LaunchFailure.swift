//
//  LaunchFailure.swift
//  SpaceXLaunches
//
//  Created by Shajir Kalady on 9/23/22.
//

import Foundation

struct LaunchFailure: Codable{
    var time: Int? = nil
    var altitude: Int? = nil
    var reason: String? = nil
}

