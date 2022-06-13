//
//  RequestError.swift
//  DNF
//
//  Created by Max Rogers on 6/10/22.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case missingToken
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .unauthorized:
            return "Session expired"
        case .missingToken:
            return "Missing token"
        default:
            return "Unknown error"
        }
    }
}
