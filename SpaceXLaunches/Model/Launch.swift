//
//  Launch.swift
//  SpaceXLaunches
//
//  Created by Shajir Kalady on 9/23/22.
//

import Foundation

struct Launch: Codable {
    var flightNumber: Int
    var missionName: String? = nil
    var missionId: [String] = []
    var upcoming: Bool = false
    var launchYear: String? = nil
    var launchDateUnix: Double? = nil
    var launchDateUtc: String? = nil
    var launchDateLocal: String? = nil
    var isTentative: Bool = false
    var tentativeMaxPrecision: String? = nil
    var tbd: Bool = false
    var launchWindow: Int? = nil
    var rocket: Rocket? = nil
    var ships: [String]? = []
    var telemetry: Telemetry? = nil
    var launchSite: LaunchSite? = nil
    var launchSuccess: Bool? = false
    var launchFailureDetails: LaunchFailure? = nil
    var links: Links? = nil
    var details: String? = nil
    var staticFireDateUtc: String? = nil
    var staticFireDateUnix: Double? = nil
    var timeline: [String: Int?]? = nil
    var crew: [String]? = nil
    var lastDateUpdate: String? = nil
    var lastLlLaunchDate: String? = nil
    var lastLlUpdate: String? = nil
    var lastWikiLaunchDate: String? = nil
    var lastWikiRevision: String? = nil
    var lastWikiUpdate: String? = nil
    var launchDateSource: String? = nil
    
    /// Compted preprties
    /// Date from unix to  Date
    var launchDateIos: Date? {
        if let date = launchDateUnix {
            return Date(timeIntervalSince1970: date)
        }
        else{
            return nil
        }
    }

    var staticFireDateIos: Date? {
        if let date = staticFireDateUnix {
            return Date(timeIntervalSince1970: date)
        }
        else{
            return nil
        }
    }
    
    var sortedTimeline: [(String, Int?)]? {
        if let timeline = timeline {
            var timelineMapped = timeline.map{$0}
            timelineMapped = timelineMapped.sorted(by: {$0.value ?? 0 < $1.value ?? 0})
            return timelineMapped
        }
        else {
            return nil
        }
    }
}

struct Telemetry: Codable {
    var flightClub: String? = nil
}
