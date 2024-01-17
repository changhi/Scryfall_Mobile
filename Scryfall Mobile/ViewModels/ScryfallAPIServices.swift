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
    func searchForCard(query: String) -> AnyPublisher<[QueryObject]?,Never>
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
    private var urlCache: [String:[QueryObject]?]
    
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
    
    func searchForCard(query: String) -> AnyPublisher<[QueryObject]?, Never> {
        if urlCache[query] != nil {
            return Just<[QueryObject]?>(urlCache[query]!).eraseToAnyPublisher()
        }
        guard let url = generateURL(with: generateURLQueryItems(query: query)) else { return Just<[QueryObject]?>(nil).eraseToAnyPublisher() }
        print(url)
        
        return urlSession.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: QueryList.self, decoder: jsonDecoder)
            .map { data in
                return data.data
            }
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
}

struct QueryList: Decodable {
    let numCards: Int?
    let data: [QueryObject]?
    
    enum CodingKeys: CodingKey {
        case numCards
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.numCards = try container.decode(Int.self, forKey: .numCards)
        self.data = try container.decode([QueryObject].self, forKey: .data)
    }
}

struct QueryObject: Decodable, Identifiable {
    let id: UUID
    let object: String
    let image_uris: [String:URL]
}
