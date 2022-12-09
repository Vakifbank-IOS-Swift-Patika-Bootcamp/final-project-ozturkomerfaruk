//
//  GameDetailModel.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 9.12.2022.
//

import Foundation

struct GameDetailModel: Decodable {
    
    //GameListModelinden gelen bir de;
    //shortScreenShots, tags
    let website: String
    let publishers: [PublisherModel]
    let descriptionRaw: String
    
    enum CodingKeys: String, CodingKey {
        case website
        case publishers
        case descriptionRaw = "description_raw"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.website = try values.decodeIfPresent(String.self, forKey: .website) ?? ""
        self.publishers = try values.decodeIfPresent([PublisherModel].self, forKey: .publishers) ?? []
        self.descriptionRaw = try values.decodeIfPresent(String.self, forKey: .descriptionRaw) ?? ""
    }
}
