//
//  FoundationExtensions.swift
//  DNF
//
//  Created by Max Rogers on 6/10/22.
//

import Foundation

extension URL {
    subscript(queryParam: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParam })?.value
    }
}
