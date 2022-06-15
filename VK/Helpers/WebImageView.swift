//
//  WebImageView.swift
//  VK
//
//  Created by Jahongir Anvarov on 15.06.2022.
//

import Foundation
import UIKit

class WebImageView: UIImageView {
    
    func set(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        
        // проверим, если фото группы или друга уже подгружено то не будем его загружать заново и сэкономим на этом время и ресурсы, те загрузим один раз дальше будем использовать из кэша
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: cachedResponse.data)
            print("from cache")
            return
        }
        print("from internet")
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self?.image = UIImage(data: data)
                    self?.handleImageLoaded(data: data, response: response)
                }
            }
        }
        dataTask.resume()
    }
    
    private func handleImageLoaded(data: Data, response: URLResponse){
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
    }
}
