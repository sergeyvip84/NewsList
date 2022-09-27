//
//  DataProvider.swift
//  NewsList
//
//  Created by Serhii Palamarchuk on 28.09.2022.
//

import UIKit

class DataProvider {
    
    static let share = DataProvider()
    
    var imageCache = NSCache<NSString, UIImage>()
    
    func downloadImage(url: String, completion: @escaping (UIImage?) -> Void) {
        
        let url = URL(string: url)!
        
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
        } else {
            let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
            let dataTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                
                guard error == nil,
                    data != nil,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200,
                    let `self` = self else {
                        return
                }
                
                guard let image = UIImage(data: data!) else { return }
                self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                
                DispatchQueue.main.async {
                    completion(image)
                }
            }
            
            dataTask.resume()
        }
    }
}
