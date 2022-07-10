//
//  DNFText.swift
//  DNF
//
//  Created by Max Rogers on 7/10/22.
//

import SwiftUI

/*
 A shared TextView to use for consistent themeing
 */

struct DNFText: View {
    let text: String
    
    init(_ text: String? = nil) {
        self.text = text ?? ""
    }
    
    var body: some View {
        Text(text)
            .foregroundColor(DNFPreferences.colors.textColor)
    }
}

struct DNFText_Previews: PreviewProvider {
    static var previews: some View {
        DNFButton(title: "Test Button")
    }
}
