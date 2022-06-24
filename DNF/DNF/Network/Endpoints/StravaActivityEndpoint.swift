//
//  StravaActivityEndpoint.swift
//  DNF
//
//  Created by Max Rogers on 6/13/22.
//

import Foundation

struct StravaActivityEndpoint: Endpoint {

    let type: StravaActivityRequestType
    let id: String?
    
    init(type: StravaActivityRequestType, id: String? = nil) {
        self.type = type
        self.id = id
    }
    
    var path: String {
        switch type {
        case .list:
            return "/athlete/activities"
        case .detail:
            return "/activities/\(id ?? "")"
        }
    }
    
    var queryParams: [String : String]? {
        switch type {
        case.list:
            return ["per_page" : "200"]
        case .detail:
            return ["include_all_efforts" : "true"]
        }
    }
    var headers: [String : String]?
    var body: [String : String]?
    
}

enum StravaActivityRequestType {
    case list, detail
}

