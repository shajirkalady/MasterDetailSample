//
//  Rocket.swift
//  SpaceXLaunches
//
//  Created by Shajir Kalady on 9/23/22.
//

import Foundation

struct Rocket: Codable {
    var rocketId: String? = nil
    var rocketName: String? = nil
    var rocketType: String? = nil
    var firstStage: FirstStage? = nil
    var secondStage: SecondStage? = nil
    var fairings: Fairings?  = nil
}
