//
//  StoreBaseResponse.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 8.12.2022.
//

import Foundation

struct StoreBaseResponse: Decodable {
    let id: Int
    let store: [Stores]
    
    enum CodingKeys: String, CodingKey {
        case id
        case store
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.store = try container.decode([Stores].self, forKey: .store) ?? []
    }
}

struct Stores: Decodable {
    let id: Int
    let name: String
    let slug: String
    let domain: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case slug
        case domain
    }
}
