//
//  ContentView.swift
//  Scryfall Mobile
//
//  Created by Daniel Chang on 1/1/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var cardName = ""

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    ScryFallTitle()
                    SearchView(cardName: $cardName)
                    SearchButton(cardName: $cardName)
                }
                LinearGradient(gradient: Gradient(colors: [Color("DarkPurple"), Color("LightPurple")]),
                               startPoint: .top,
                               endPoint: .bottom)
                .ignoresSafeArea()
                .zIndex(-1.00)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
