//
//  FoundationExtensions.swift
//  DNF
//
//  Created by Max Rogers on 6/10/22.
//

import SwiftUI

// MARK: String

extension String {
    
    /// Converts an ISO8601 string to a date
    var isoDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.date(from: self) ?? Date()
    }
    
}

// MARK: Date

extension Date {
    
    /// Returns month component
    var month: Int {
        Calendar.current.component(.month, from: self)
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
    
    /// Converts a value in meters to miles and returns a string
    var metersToMilesStringValue: String {
        String(format: "%.2f", self.metersToMilesValue)
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
    
    /// Converts int to string value
    var stringValue: String {
        "\(self)"
    }
    
    // MARK: Unit Conversion
    
    /// Converts a value in meters to feet
    var metersToFeetValue: Int {
        return Int((Double(self) * 3.28084))
    }
    
}

// MARK: URL

extension URL {
    /// Ability to check query params via a subscript
    subscript(queryParam: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParam })?.value
    }
}

// MARK: Colors

/*
https://stackoverflow.com/a/64414674
 */

extension Color {
     
    // MARK: - Text Colors
    static let lightText = Color(UIColor.lightText)
    static let darkText = Color(UIColor.darkText)
    static let placeholderText = Color(UIColor.placeholderText)

    // MARK: - Label Colors
    static let label = Color(UIColor.label)
    static let secondaryLabel = Color(UIColor.secondaryLabel)
    static let tertiaryLabel = Color(UIColor.tertiaryLabel)
    static let quaternaryLabel = Color(UIColor.quaternaryLabel)

    // MARK: - Background Colors
    static let systemBackground = Color(UIColor.systemBackground)
    static let secondarySystemBackground = Color(UIColor.secondarySystemBackground)
    static let tertiarySystemBackground = Color(UIColor.tertiarySystemBackground)
    
    // MARK: - Fill Colors
    static let systemFill = Color(UIColor.systemFill)
    static let secondarySystemFill = Color(UIColor.secondarySystemFill)
    static let tertiarySystemFill = Color(UIColor.tertiarySystemFill)
    static let quaternarySystemFill = Color(UIColor.quaternarySystemFill)
    
    // MARK: - Grouped Background Colors
    static let systemGroupedBackground = Color(UIColor.systemGroupedBackground)
    static let secondarySystemGroupedBackground = Color(UIColor.secondarySystemGroupedBackground)
    static let tertiarySystemGroupedBackground = Color(UIColor.tertiarySystemGroupedBackground)
    
    // MARK: - Gray Colors
    static let systemGray = Color(UIColor.systemGray)
    static let systemGray2 = Color(UIColor.systemGray2)
    static let systemGray3 = Color(UIColor.systemGray3)
    static let systemGray4 = Color(UIColor.systemGray4)
    static let systemGray5 = Color(UIColor.systemGray5)
    static let systemGray6 = Color(UIColor.systemGray6)
    
    // MARK: - Other Colors
    static let separator = Color(UIColor.separator)
    static let opaqueSeparator = Color(UIColor.opaqueSeparator)
    static let link = Color(UIColor.link)
    
    // MARK: System Colors
    static let systemBlue = Color(UIColor.systemBlue)
    static let systemPurple = Color(UIColor.systemPurple)
    static let systemGreen = Color(UIColor.systemGreen)
    static let systemYellow = Color(UIColor.systemYellow)
    static let systemOrange = Color(UIColor.systemOrange)
    static let systemPink = Color(UIColor.systemPink)
    static let systemRed = Color(UIColor.systemRed)
    static let systemTeal = Color(UIColor.systemTeal)
    static let systemIndigo = Color(UIColor.systemIndigo)

}

