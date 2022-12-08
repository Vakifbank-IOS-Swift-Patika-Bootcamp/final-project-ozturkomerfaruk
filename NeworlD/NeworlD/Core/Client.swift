//
//  Client.swift
//  NeworlD
//
//  Created by Ömer Faruk Öztürk on 8.12.2022.
//

import Foundation

final class Client {
    
    @discardableResult
    private class func tasksForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping(ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(GameBaseResponse.self, from: data) as? Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
        return task
    }
    
    class func getGameList(page: Int, pageSize: Int, completion: @escaping([GameModel]?, Error?) -> Void) {
        tasksForGETRequest(url: EndPoints.getGameList(page, pageSize).url, responseType: GameBaseResponse.self) { response, error in
            if let response = response {
                completion(response.results, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}
