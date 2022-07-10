//
//  DNFPreferences.swift
//  DNF
//
//  Created by Max Rogers on 7/10/22.
//

import SwiftUI

// TODO use AppStorage UserDefault wrapper where necessary

struct DNFPreferences {
    static let colors = DNFColors()
}

struct DNFColors {
    
    /// The primary text color to be used on views
    private(set) var textColor: Color {
        get {
            // fetch from app storage? or user defaults
            return Color.primary
        }
        set {
            // store to app storage? or user defaults
        }
    }
    
    /// The primary background color to be used on views
    private(set) var backgroundColor: Color {
        get {
            // fetch from app storage? or user defaults
            return Color.systemBackground
        }
        set {
            // store to app storage? or user defaults
        }
    }
    
    /// The primary accent color to be used on views
    private(set) var accentColor: Color {
        get {
            // fetch from app storage? or user defaults
            return Color.accentColor
        }
        set {
            // store to app storage? or user defaults
        }
    }
    
}
