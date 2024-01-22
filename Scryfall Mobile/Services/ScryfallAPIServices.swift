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
    func fetchResults(query: String, completion: @escaping (Result<QueryList, Error>) -> Void)
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
    
    func fetchResults(query: String, completion: @escaping (Result<QueryList, Error>) -> Void) {
        guard let url = generateURL(with: generateURLQueryItems(query: query)) else { return }
        urlSession.dataTask(with: url) { [self] data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            do {
                let results = try jsonDecoder.decode(QueryList.self, from: data!)
                completion(.success(results))
            }
            catch let err {
                completion(.failure(err))
            }
        }.resume()
        
    }
}

struct QueryList: Decodable {
    let total_cards: Int?
    let data: [QueryObject]?
    
    enum CodingKeys: CodingKey {
        case total_cards
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.total_cards = try container.decode(Int.self, forKey: .total_cards)
        self.data = try container.decode([QueryObject].self, forKey: .data)
    }
}

struct QueryObject: Decodable, Identifiable {
    let id: UUID
    let object: String
    let image_uris: [String:URL]
    let name: String
}
