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
    let title: LocalizedStringKey
    var body: some View {
        Text(title)
            .buttonStyle(.plain)
    }
}

struct DNFButton_Previews: PreviewProvider {
    static var previews: some View {
        DNFButton(title: "Test Button")
    }
}
