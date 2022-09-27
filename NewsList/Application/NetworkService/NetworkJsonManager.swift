//
//  Network.swift
//  NewsList
//
//  Created by Serhii Palamarchuk on 27.09.2022.
//

import Foundation
struct NetworkJsonManager {
    
    static func fetchJson<T>(urlString: String, type: T.Type, completionHangler: @escaping (T) -> Void ) where T : Decodable {
        
        guard let url = URL(string: urlString) else {
            print("could not convert to URL: \(urlString)")
            return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let dataJson = try JSONDecoder().decode(type, from: data)
                completionHangler(dataJson)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
