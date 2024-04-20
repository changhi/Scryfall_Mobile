//
//  CardViewModel.swift
//  Scryfall Mobile
//
//  Created by Daniel Chang on 1/28/24.
//

import Foundation
import SwiftUI


class CardViewModel: ObservableObject {
    @Published var card: QueryObject
    
    init(card: QueryObject) {
        self.card = card
    }
    
}


extension LocalizedStringKey {

    private static let imageMap: [String: String] = [
        "T": "Tap"
    ]

    init(imageText: String) {
        var components = [Any]()
        var length = 0
        let scanner = Scanner(string: imageText)
        scanner.charactersToBeSkipped = nil
        while scanner.isAtEnd == false {
            let up = scanner.scanUpToString("{")
            let start = scanner.scanString("{")
            let name = scanner.scanUpToString("}")
            let end = scanner.scanString("}")
            if let up = up {
                components.append(up)
                length += up.count
            }
            if let name = name {
                if start != nil, end != nil, let imageName = Self.imageMap[name] {
                    components.append(Image(imageName))
                    length += 1
                } else {
                    components.append(name)
                }
            }
        }

        var interp = LocalizedStringKey.StringInterpolation(literalCapacity: length, interpolationCount: components.count)
        for component in components {
            if let string = component as? String {
                interp.appendInterpolation(string)
            }
            if let image = component as? Image {
                interp.appendInterpolation(image)
            }
        }

        self.init(stringInterpolation: interp)
    }
}

extension Text {
    init(imageText: String) {
        self.init(LocalizedStringKey(imageText: imageText))
    }
}
