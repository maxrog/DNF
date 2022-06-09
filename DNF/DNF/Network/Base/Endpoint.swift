//
//  Endpoint.swift
//  DNF
//
//  Created by Max Rogers on 6/9/22.
//

import Foundation

/*
 The base Endpoint protocol for creating an http call.
 Specific Endpoints can conform and provide their necessary paths etc.
 */

protocol Endpoint {
    /// The base. Defaults to configuration setting
    var baseURL: String { get }
    
    /// The path
    var path: String { get }
    
    /// The http method type. Defaults to GET
    var method: RequestMethod { get }
    
    /// Optional headers to supply
    var header: [String: String]? { get }
    
    /// Optional body to supply
    var body: [String: String]? { get }
}

extension Endpoint {
    
    var baseURL: String {
        let plist = FileManager.plist(named: "NetworkConfiguration", childName: "Strava")
        return plist["StravaBaseUrl"] as? String ?? ""
    }
    
    var method: RequestMethod {
        return .get
    }
    
}

enum RequestMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}
