//
//  NewsFeedInteractor.swift
//  VK
//
//  Created by Jahongir Anvarov on 21.01.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
  func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {

  var presenter: NewsFeedPresentationLogic?
  var service: NewsFeedService?
    
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
 
  func makeRequest(request: NewsFeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsFeedService()
    }
      
    switch request {

    case .getNewsFeed:

        fetcher.getFeed { [weak self] (feedResponse) in
// это все примеры типа дебаг
//            feedResponse?.groups.map({ (profile) in
//                print("Profile: \(profile) \n\n")
//            })
//
//            feedResponse?.items.map({ feedItem in
//                print(feedItem.sourceId)
//            })
            feedResponse?.items.map({ feedIem in
                print("attachments =  \(feedIem.attechments)")
            })
            
            guard let feedResponse = feedResponse else { return }
           // self?.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentNewsFeed)
            self?.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentNewsFeed(feed: feedResponse))
        }
    }
  }
  
}
