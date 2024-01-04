//
//  SearchView.swift
//  Scryfall Mobile
//
//  Created by Daniel Chang on 1/1/24.
//

import Foundation
import SwiftUI

struct SearchView: View {
    @State var cardName: String = ""
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
            .border(.white)
        }
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            SearchView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
