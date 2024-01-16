//
//  ScryfallAPIServices.swift
//  Scryfall Mobile
//
//  Created by Daniel Chang on 1/8/24.
//

import Foundation
import Combine
import SwiftUI

protocol ScryfallCardFetcherAPIServices {
    func searchForCard(query: String) -> AnyPublisher<URL?,Never>
}

class ScryfallAPIServices: ScryfallCardFetcherAPIServices {
    static let shared = ScryfallAPIServices()
    private let baseAPIURL = "https://api.scryfall.com/cards/search"
    private let urlSession = URLSession.shared
    private let jsonDecoder: JSONDecoder = {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .millisecondsSince1970
                return decoder
            }()
    private var urlCache: [String:URL?]
    
    private init() {
        self.urlCache = [:]
    }
    
    private func generateURLQueryItems(query: String? = nil, format: String = "json") -> [URLQueryItem] {
        var items = [URLQueryItem]()
        
        items.append(URLQueryItem(name:"q", value: query))
        items.append(URLQueryItem(name: "format", value: format))
        
        return items
    }
    
    private func generateURL(with queryItems: [URLQueryItem]) -> URL? {
        guard var urlComponents = URLComponents(string: baseAPIURL) else {
            return nil
        }
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
    
    func searchForCard(query: String) -> AnyPublisher<URL?, Never> {
        if urlCache[query] != nil {
            return Just<URL?>(urlCache[query]!).eraseToAnyPublisher()
        }
        
        guard let url = generateURL(with: generateURLQueryItems(query: query)) else { return Just<URL?>(nil).eraseToAnyPublisher() }
        print(query, url)
        
        return Just<URL?>(nil).eraseToAnyPublisher()
    }
}
