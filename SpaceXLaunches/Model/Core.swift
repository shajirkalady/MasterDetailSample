//
//  Core.swift
//  SpaceXLaunches
//
//  Created by Shajir Kalady on 9/23/22.
//

import Foundation

struct Core: Codable{
    var coreSerial: String? = nil
    var flight: Int? = nil
    var block: Int? = nil
    var gridfins: Bool? = nil
    var legs: Bool? = nil
    var reused: Bool? = nil
    var landSuccess: Bool? = nil
    var landingIntent: Bool? = nil
    var landingType: String? = nil
    var landingVehicle: String? = nil
}
