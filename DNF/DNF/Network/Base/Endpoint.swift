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
    var methodType: RequestMethod { get }
    
    /// Optional query params to supply
    var queryParams: [String: String]? { get }
    
    /// Optional headers to supply
    var headers: [String: String]? { get }
    
    /// Optional body to supply
    var body: [String: String]? { get }
    
    /// The final computed url
    var urlRequest: URLRequest? { get }
    
    /// A url request with bearer token attached (async because we may need to refresh token)
    func authorizedRequest() async throws -> URLRequest?
}

/*
 Default implementation
 */
extension Endpoint {
    
    var baseURL: String {
        return StravaAPIConfiguration.shared.stravaBaseUrl
    }
    
    var methodType: RequestMethod {
        return .get
    }
    
    var url: URL? {
        return urlRequest?.url
    }
    
    // Everything combined
    var urlRequest: URLRequest? {
        
        let urlString = baseURL + path
        
        guard var urlComponents = URLComponents(string: urlString) else {
            let message = "Error building url components from \(urlString)"
            DNFLogger.log(.error, message, sender: String(describing: self))
            return nil
        }
        
        if let queryParams {
            urlComponents.queryItems = queryParams.compactMap({ URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        guard let url = urlComponents.url else {
            let message = "Error accessing url from \(urlComponents.string ?? "N/A")"
            DNFLogger.log(.error, message, sender: String(describing: self))
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = methodType.rawValue
        
        if let headers {
            request.allHTTPHeaderFields = headers
        }
        
        if let body,
           let jsonBody = try? JSONSerialization.data(withJSONObject: body) {
            request.httpBody = jsonBody
        }
        
        return request
    }
    
    func authorizedRequest() async throws -> URLRequest? {
        let token = try await AuthManager.shared.validToken()
        guard var request = urlRequest else {
            throw RequestError.missingToken
        }
        request.setValue("Bearer \(token.accessToken)", forHTTPHeaderField: "Authorization")
        return request
    }
    
}

enum RequestMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}
