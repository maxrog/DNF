//
//  FoundationExtensions.swift
//  DNF
//
//  Created by Max Rogers on 6/10/22.
//

import Foundation

// MARK: URL

extension URL {
    /// Ability to check query params via a subscript
    subscript(queryParam: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParam })?.value
    }
}

// MARK: Double

extension Double {
    
    // MARK: Formatting
    
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    // MARK: Unit conversion
   
    /// Converts a value in meters to miles
    var metersToMilesValue: Double {
        return (self / 1609.34).rounded(toPlaces: 2)
    }
    
}

// MARK: Int

extension Int {
    
    // MARK: Formatting
    
    /// Converts the time interval (in seconds), to hh:mm:ss format
    var hhmmssStringValue: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = [.pad]
        
        return formatter.string(from: TimeInterval(self)) ?? ""
    }
    
    // MARK: Unit Conversion
    
    /// Converts a value in meters to feet
    var metersToFeetValue: Int {
        return Int((Double(self) * 3.28084))
    }
    
}


// MARK: String

extension String {
    
    /// Converts an ISO8601 string to a date
    var isoDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.date(from: self) ?? Date()
    }
    
}
