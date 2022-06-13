//
//  NewsFeedViewController.swift
//  VK
//
//  Created by Jahongir Anvarov on 21.01.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedDisplayLogic: class {
  func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData)
}

class NewsFeedViewController: UIViewController, NewsFeedDisplayLogic {

  var interactor: NewsFeedBusinessLogic?
  var router: (NSObjectProtocol & NewsFeedRoutingLogic)?

    private var feedViewMdel = FeedViewModel.init(cells: [])
    
    @IBOutlet weak var table: UITableView!
    
//  // MARK: Object lifecycle
//
//  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    setup()
//  }
//
//  required init?(coder aDecoder: NSCoder) {
//    super.init(coder: aDecoder)
//    setup()
//  }
  
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = NewsFeedInteractor()
    let presenter             = NewsFeedPresenter()
    let router                = NewsFeedRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  

  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
      setup()
      
      //table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
      table.register(UINib(nibName: "NewsFeedCell", bundle: nil), forCellReuseIdentifier: NewsFeedCell.reuseID)
      interactor?.makeRequest(request: NewsFeed.Model.Request.RequestType.getNewsFeed)
  }
  
  func displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData) {

      switch viewModel {
      case .displayNewsFeed(feedViewModel: let feedViewModel):
          self.feedViewMdel = feedViewModel
          table.reloadData()
          print("//")
      }
  }
  
}


extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        feedViewMdel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell
//        cell.textLabel?.text = "index: \(indexPath.row)"
//        return cell
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsFeedCell.reuseID, for: indexPath) as! NewsFeedCell
//        cell.set(viewModel: <#T##FeedCellViewModel#>)
        let cellViewModel = feedViewMdel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        return cell
    }
/* Это удалаем и сделаем по другому
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.makeRequest(request: .getFeed)
    }
*/
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 212
    }
}
