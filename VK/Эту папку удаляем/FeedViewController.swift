//
//  FeedViewController.swift
//  VK
//
//  Created by Jahongir Anvarov on 18.01.2022.
//

import Foundation
import UIKit


class FeedViewController: UIViewController {
    
  //  private let networkService: Networking = NetworkService()
    
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
//        networkService.getFeed()
//        let params = ["filters": "post, photo"]
//        networkService.request(path: API.newsFeed, params: params) { (data, error) in
//            if let error = error {
//                print("Error received request data: \(error.localizedDescription)")
//            }
//
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            guard let data = data else {return}
///            let json = try? JSONSerialization.jsonObject(with: data, options: [])
////            print("json: \(json)")
//            let response = try? decoder.decode(FeedResponseWrapped.self, from: data)
////            print(response)
////            response?.response.items.map({ feedItem in
////                print(feedItem.text)
////            })
//        }
        fetcher.getFeed { feedResponse in
            guard let feedResponse = feedResponse else {return}
            feedResponse.items.map { feedItem in
                print(feedItem.date)
            }
        }
    }
}
