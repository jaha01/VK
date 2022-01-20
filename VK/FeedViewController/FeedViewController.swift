//
//  FeedViewController.swift
//  VK
//
//  Created by Jahongir Anvarov on 18.01.2022.
//

import Foundation
import UIKit


class FeedViewController: UIViewController {
    
    private let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
//        networkService.getFeed()
        let params = ["filters": "post, photo"]
        networkService.request(path: API.newsFeed, params: params) { data, error in
            if let error = error {
                print("Error received request data: \(error.localizedDescription)")
            }
            guard let data = data else {return}
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            print("json: \(json)")
        }
    }
}
