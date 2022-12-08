//
//  Endpoints.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 8.12.2022.
//

import Foundation

enum EndPoints {
    static private let BASE_GAME = "https://api.rawg.io/api/games?key=" + Constants.API_KEY
    
    case getGameList(Int, Int)
    
    var stringValue: String {
        switch self {
        case .getGameList(let page, let pageSize):
            return EndPoints.BASE_GAME + "&page=\(page)&page_size=\(pageSize)"
            
        }
    }
    
    var url: URL {
        return URL(string: stringValue)!
    }
}
