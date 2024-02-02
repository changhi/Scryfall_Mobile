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
    @Published var orcale: [String]
    @Published var orcaleOrder: [String]
    
    init(card: QueryObject) {
        self.card = card
        orcale = []
        orcaleOrder = []
    }
    
    func convertOrcaleText() {
        let scanner = Scanner(string: card.oracle_text)
        scanner.charactersToBeSkipped = nil
        
        while scanner.isAtEnd == false {
            let up = scanner.scanUpToString("{")
            let start = scanner.scanString("{")
            let text = scanner.scanUpToString("}")
            let end = scanner.scanString("}")
            
            if let up = up {
                orcale.append(up)
                orcaleOrder.append("t")
            }
            if let name = text {
                if start != nil, end != nil, let imageName = MTGSymbols.imageMap[name] {
                    orcale.append(imageName)
                    orcaleOrder.append("i")
                } else {
                    orcale.append(name)
                    orcaleOrder.append("t")
                }
            }
        }
        print(orcale)
    }
}

struct MTGSymbols {
    static let imageMap = [
        "T" : "tapSymbol"
    ]
}

