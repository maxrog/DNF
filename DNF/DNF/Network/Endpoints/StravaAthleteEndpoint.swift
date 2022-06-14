//
//  StravaAthleteEndpoint.swift
//  DNF
//
//  Created by Max Rogers on 6/10/22.
//

import Foundation

struct StravaAthleteEndpoint: Endpoint {
    
    let type: StravaAthleteRequestType
    
    var path: String {
        switch type {
        case .info:
            return "/athlete"
        case .stats:
            return "/athletes/\(StravaAPIConfiguration.shared.athleteId)/stats"
        }
    }
    
    var queryParams: [String : String]?
    var headers: [String : String]?
    var body: [String : String]?
    
}

enum StravaAthleteRequestType {
    case info, stats
}
