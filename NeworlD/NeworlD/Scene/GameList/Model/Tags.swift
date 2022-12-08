//
//  Tags.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 8.12.2022.
//

import Foundation

struct Tags: Decodable {
    let id: Int
    let name: String
    let slug: String
    let language: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case slug
        case language
    }
}
