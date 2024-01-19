//
//  SearchResultView.swift
//  Scryfall Mobile
//
//  Created by Daniel Chang on 1/4/24.
//

import Foundation
import SwiftUI

struct SearchResultView: View {
    @StateObject var vm: SearchResultViewModel
    
    var body: some View {
        VStack {
            if let cards = vm.cards {
                Text(cards.data![0].object)
            } else {
                Text("hello")
            }
        }.onAppear {
            vm.searchQuery()
        }
    }
}
