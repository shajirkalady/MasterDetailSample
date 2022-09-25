//
//  Payload.swift
//  SpaceXLaunches
//
//  Created by Shajir Kalady on 9/23/22.
//

import Foundation

struct Payload: Codable {
    var payloadId: String? = nil
    var noradId: [Int]? = nil
    var capSerial: String? = nil
    var reused: Bool? = nil
    var customers: [String]? = nil
    var nationality: String? = nil
    var manufacturer: String? = nil
    var payloadType: String? = nil
    var payloadMassKg: Double? = nil
    var payloadMassLbs: Double? = nil
    var orbit: String? = nil
    var orbitParams: Orbit? = nil
    var uid: String? = nil
    var massReturnedKg: Double? = nil
    var massReturnedLbs: Double? = nil
    var flightTimeSec: Int? = nil
    var cargoManifest: String? = nil
    
    func joinedNoralId() -> String {
        if let arr = self.noradId {
            let strArr = arr.map{ String($0) }
            return strArr.joined(separator: ", ")
        }
        
        return "-"
    }
    
    func joinedCustomers() -> String{
        if let arr = self.customers {
            return arr.joined(separator: ", ")
        }
        else {
            return "-"
        }
    }
}
