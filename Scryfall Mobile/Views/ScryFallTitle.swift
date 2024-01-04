//
//  ScryFallTitle.swift
//  Scryfall Mobile
//
//  Created by Daniel Chang on 1/3/24.
//

import Foundation
import SwiftUI

struct ScryFallTitle: View {
    var body: some View {
        VStack {
            Text("**Scryfall** is a powerful **Magic: The Gathering card search**")
                .foregroundColor(.white)
                .lineLimit(1)
        }
    }
}
