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
    @Published var url: URL?
    @Published var numResults: Int?
    
    init(query: Binding<String>) {
        self.cards = nil
        self._query = query
    }
    
    func searchQuery() {
        ScryfallAPIServices.shared.fetchResults(query: query) { [weak self] result in
            switch result {
            case .success(let results):
                self?.cards = results.data
                self?.numResults = results.total_cards
            case .failure(let error):
                print(error)
            }
        }
    }
}
