//
//  CardView.swift
//  Scryfall Mobile
//
//  Created by Daniel Chang on 1/22/24.
//

import Foundation
import SwiftUI

struct CardView: View {
    @StateObject var vm: CardViewModel
    private let screenWidth =  UIScreen.main.bounds.size.width - 40
    @ScaledMetric(relativeTo: .body) var imageSize = 17
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 20) {
                    HStack {
                        AsyncImage(url: vm.card.image_uris["normal"]) { image in
                            image.image?
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                    .frame(maxWidth: screenWidth, alignment: .leading)
                    VStack(alignment: .leading) {
                        Text(vm.card.name)
                            .padding(10)
                        Divider()
                        Text(vm.card.type_line)
                            .padding(10)
                        Divider()
                        Text(imageText: vm.card.oracle_text)
                        
                    }.frame(maxWidth: screenWidth, alignment: .leading)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.black, lineWidth: 3))
                }
            }
        }
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(vm: CardViewModel(card: QueryObject(id: UUID(),
                                   object: "card",
                                   image_uris: ["normal": URL(string: "https://cards.scryfall.io/normal/front/f/e/feefe9f0-24a6-461c-9ef1-86c5a6f33b83.jpg?1594681430")!],
                                   name: "Birds of Paradise",
                                   type_line: "Creature — Bird",
                                   oracle_text: "Flying\n{T}: Add one mana of any color."
                                  )))
    }
}

