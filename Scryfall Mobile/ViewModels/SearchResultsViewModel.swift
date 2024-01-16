//
//  SearchResultsViewModel.swift
//  Scryfall Mobile
//
//  Created by Daniel Chang on 1/13/24.
//

import Foundation
import SwiftUI

class SearchResultViewModel {
    //@Published var url: URL
    
    init(query: String, service: ScryfallAPIServices) {
        print(service.searchForCard(query: query))
    }
}
