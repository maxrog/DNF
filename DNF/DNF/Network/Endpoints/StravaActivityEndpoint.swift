//
//  StravaActivityEndpoint.swift
//  DNF
//
//  Created by Max Rogers on 6/13/22.
//

import Foundation

struct StravaActivityEndpoint: Endpoint {

    let type: StravaActivityRequestType
    
    var path: String {
        switch type {
        case .list:
            return "/athlete/activities"
        case .stream:
            return "/activities/\(StravaAPIConfiguration.runActivityType)/streams"
        }
    }
    
    var queryParams: [String : String]? {
        switch type {
        case.list:
            return ["per_page" : "200"]
        case .stream:
            return nil
        }
    }
    var headers: [String : String]?
    var body: [String : String]?
    
}

enum StravaActivityRequestType {
    case list, stream
}

