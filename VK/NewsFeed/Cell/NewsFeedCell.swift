//
//  NewsFeedCell.swift
//  VK
//
//  Created by Jahongir Anvarov on 23.01.2022.
//

import UIKit

protocol FeedCellViewModel {
    var iconUrlString: String { get }
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var likes: String? { get }
    var comments: String? { get }
    var shares: String? { get }
    var views: String? { get }
    var photoAttechment: FeedCellPhotoAttachmentViewModel? { get }
    
}

protocol FeedCellPhotoAttachmentViewModel {
    var photoUrlString: String? { get }
    var height: Int { get }
    var width: Int { get }
}

class NewsFeedCell: UITableViewCell {

    static let reuseID = "NewsFeedCell"
    
    @IBOutlet weak var iconImageView: WebImageView!//UIImageView!
    @IBOutlet weak var postImageView: WebImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
  //      iconImageView.clipsToBounds = true
    }
    
    func set(viewModel: FeedCellViewModel){
        iconImageView.set(imageURL: viewModel.iconUrlString) // тянет фото с сервера через  функцию в WebImageView
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        
        if let photoAttechment = viewModel.photoAttechment {
            postImageView.set(imageURL: photoAttechment.photoUrlString)
            print("HERE WE ARE!")
            postImageView.isHidden = false
        } else {
            postImageView.isHidden = true
        }
    }
}
