//
//  SearchResultsViewModel.swift
//  Scryfall Mobile
//
//  Created by Daniel Chang on 1/13/24.
//

import Foundation
import SwiftUI

class SearchResultViewModel: ObservableObject {
    @Binding var query: String
    @Published var cards: [QueryObject]?
    
    init(query: Binding<String>) {
        self.cards = nil
        self._query = query
    }
    
    func searchQuery() {
        ScryfallAPIServices.shared.searchForCard(query: query).assign(to: &$cards)
    }
}
