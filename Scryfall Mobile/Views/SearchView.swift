//
//  SearchView.swift
//  Scryfall Mobile
//
//  Created by Daniel Chang on 1/1/24.
//

import Foundation
import SwiftUI

struct SearchView: View {
    @Binding var cardName: String
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Image(uiImage: UIImage(named: "ScryFallLogo")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    TextField("Search...", text: $cardName)
                        .foregroundColor(.white)
                }.frame(width: CGFloat(300), height: CGFloat(50), alignment: .center)
            }.background(Color("SearchBarPurple"))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 1))
        }
    }
}

struct SearchButton: View {
    @Binding var cardName: String
    var body: some View {
        VStack {
            NavigationLink("Search") {
                SearchResultView(vm: SearchResultViewModel(query: cardName, service: ScryfallAPIServices.shared))
            }.frame(width: CGFloat(100), height: CGFloat(30), alignment: .center)
                .foregroundColor(.white)
                .background(Color("SearchBarPurple"))
                .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.white, lineWidth: 1))
                
        }
    }
}
