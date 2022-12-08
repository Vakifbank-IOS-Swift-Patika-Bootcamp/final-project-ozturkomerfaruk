//
//  GameModel.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 8.12.2022.
//

import Foundation

struct GameModel: Decodable {
    let id: Int
    let slug: String
    let name: String
    let released: String
    let backgroundImage: String
    let rating: Double
    let parentPlatforms: [ParentPlatforms]
//    let genres: [Genres]
//    let stores: [StoreBaseResponse]
//    let tags: [Tags]
//    let shortScreenshots: [ShortScreenshots]
    
    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case name
        case released
        case backgroundImage = "background_image"
        case rating
        case parentPlatforms = "parent_platforms"
//        case genres
//        case stores
//        case tags
//        case shortScreenshots = "short_screenshots"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? -1
        slug = try values.decodeIfPresent(String.self, forKey: .slug) ?? ""
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        released = try values.decodeIfPresent(String.self, forKey: .released) ?? ""
        backgroundImage = try values.decodeIfPresent(String.self, forKey: .backgroundImage) ?? ""
        rating = try values.decodeIfPresent(Double.self, forKey: .rating) ?? 0.0
        parentPlatforms = try values.decodeIfPresent([ParentPlatforms].self, forKey: .parentPlatforms) ?? []
//        genres = try values.decodeIfPresent([Genres].self, forKey: .genres) ?? []
//        stores = try values.decodeIfPresent([StoreBaseResponse].self, forKey: .stores) ?? []
//        tags = try values.decodeIfPresent([Tags].self, forKey: .tags) ?? []
//        shortScreenshots = try values.decodeIfPresent([ShortScreenshots].self, forKey: .shortScreenshots) ?? []
        
    }
}
