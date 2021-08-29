//
//  HTTPManager.swift
//  MarvelAPI
//
//  Created by German Huerta on 27/08/21.
//

import Foundation

final class HTTPManager {
    
    enum HTTPError: Error {
        case invalidURL
        case invalidDecoding
        case invalidResponse(Data?, URLResponse?)
    }
    
    public func request<T: Codable>(url: URL, completionBlock: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completionBlock(.failure(error!))
                return
            }
            
            guard let responseData = data,
            let httpResponse = response as? HTTPURLResponse,
                200 ..< 300 ~= httpResponse.statusCode else {
                    completionBlock(.failure(HTTPError.invalidResponse(data, response)))
                    return
            }
            
            do {
                let str = String(data: responseData, encoding: .utf8)
                print(str)
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: responseData)
                completionBlock(.success(result))
            } catch {
                print(error)
                completionBlock(.failure(HTTPError.invalidDecoding))
            }
        }
        task.resume()
    }
}
