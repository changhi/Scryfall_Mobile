//
//  SearchResultView.swift
//  Scryfall Mobile
//
//  Created by Daniel Chang on 1/4/24.
//

import Foundation
import SwiftUI

struct SearchResultView: View {
    var body: some View {
        VStack {
            Text("Hello world")
        }
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
