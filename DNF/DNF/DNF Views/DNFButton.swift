//
//  DNFButton.swift
//  DNF
//
//  Created by Max Rogers on 6/9/22.
//

import SwiftUI

/*
 A shared parent button to use for consistent themeing
 */

struct DNFButton: View {
    let title: String
    var body: some View {
        DNFText(title)
            .buttonStyle(.plain)
    }
}

struct DNFButton_Previews: PreviewProvider {
    static var previews: some View {
        DNFButton(title: "Test Button")
    }
}
