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
                Text(vm.query)
                resultCount(query: vm.$query, numResults: vm.numResults)
                    .frame(alignment: .leading)
                NavigationStack {
                    ScrollView {
                        ForEach(cards) { card in
                            NavigationLink {
                                CardView()
                            } label: {
                                CardTile(card: card)
                            }
                        }
                    }
                }
            } else {
                Text("Something went Wrong")
            }
        }.onAppear {
            vm.searchQuery()
        }
    }
}

struct resultCount: View {
    @Binding var query: String
    var numResults: Int?
    
    var body: some View {
        HStack {
            Text("""
                 \(Text("\(numResults ?? 0) cards").foregroundColor(Color("LightPurple"))) where the name includes
                 \(Text("\"\(query)\"").foregroundColor(Color("LightPurple")))
                """)
            Spacer()
        }
    }
}

struct CardTile: View {
    @State var card: QueryObject
    
    var body: some View {
        VStack {
            Text(card.name)
            AsyncImage(url: card.image_uris["normal"]) { image in
                image.image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
    
}
