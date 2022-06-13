//
//  NewsFeedPresenter.swift
//  VK
//
//  Created by Jahongir Anvarov on 21.01.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedPresentationLogic {
  func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
  weak var viewController: NewsFeedDisplayLogic?
    let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        return dt
    }()
  
  func presentData(response: NewsFeed.Model.Response.ResponseType) {
  
      switch response {
      case .presentNewsFeed(let feed):
          let cells = feed.items.map { feedItem in
              //cellViewModel(from: feedItem)
              cellViewModel(from: feedItem, profile: feed.profiles, groups: feed.groups)
          }
          let feedViewModel = FeedViewModel.init(cells: cells)
          viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayNewsFeed(feedViewModel: feedViewModel))
      }
  }
  
    private func cellViewModel(from feedItem: FeedItem,profile: [Profile],groups: [Group]) -> FeedViewModel.Cell {
        
        let profile = self.profile(for: feedItem.sourceId, profiles: profile, groups: groups)
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        
        return FeedViewModel.Cell.init(iconUrlString: profile.photo,
                                       name: profile.name,
                                       date: dateTitle,
                                       text: feedItem.text,
                                       likes: String(feedItem.likes?.count ?? 0),
                                       comments: String(feedItem.comments?.count ?? 0),
                                       shares: String(feedItem.reposts?.count ?? 0),
                                       views: String(feedItem.views?.count ?? 0))
    }
    
    private func profile(for sourceId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentable {
        
        let profilesOrGrpoups: [ProfileRepresentable] = sourceId >= 0 ? profiles : groups
        let normalSourseId = sourceId >= 0 ? sourceId : -sourceId
        let profileRepresentable = profilesOrGrpoups.first { (myProfileRepresentable) -> Bool in
            myProfileRepresentable.id == normalSourseId
        }
        return profileRepresentable!
    }
}
