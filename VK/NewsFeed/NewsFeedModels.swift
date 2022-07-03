//
//  NewsFeedModels.swift
//  VK
//
//  Created by Jahongir Anvarov on 21.01.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum NewsFeed {
   
  enum Model {
    struct Request {
      enum RequestType {
//        case some
//        case getFeed
        case getNewsFeed
      }
    }
    struct Response {
      enum ResponseType {
          case presentNewsFeed(feed: FeedResponse)
      }
    }
    struct ViewModel {
      enum ViewModelData {
          case displayNewsFeed(feedViewModel: FeedViewModel)
      }
    }
  }
}

struct FeedViewModel {
    struct Cell: FeedCellViewModel {
        
        var iconUrlString: String
        var name: String
        var date: String
        var text: String?
        var likes: String?
        var comments: String?
        var shares: String?
        var views: String?
        var photoAttechment: FeedCellPhotoAttachmentViewModel?
    }
    struct FeedCellPhotoAttechment: FeedCellPhotoAttachmentViewModel {
        
        var photoUrlString: String?
        var height: Int
        var width: Int
    }
    
    let cells : [Cell]
}
