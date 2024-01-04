//
//  Scryfall_MobileApp.swift
//  Scryfall Mobile
//
//  Created by Daniel Chang on 1/1/24.
//

import SwiftUI

@main
struct Scryfall_MobileApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
