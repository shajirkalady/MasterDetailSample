//
//  Orbit.swift
//  SpaceXLaunches
//
//  Created by Shajir Kalady on 9/23/22.
//

import Foundation

struct Orbit: Codable{
    var referenceSystem: String? = nil
    var regime: String? = nil
    var longitude: Double? = nil
    var semiMajorAxisKm: Double? = nil
    var eccentricity: Double? = nil
    var periapsisKm: Double? = nil
    var apoapsisKm: Double? = nil
    var inclinationDeg: Double? = nil
    var periodMin: Double? = nil
    var lifespanYears: Double? = nil
    var epoch: String? = nil
    var meanMotion: Double? = nil
    var raan: Double? = nil
    var argOfPericenter: Double? = nil
    var meanAnomaly: Double? = nil
}
