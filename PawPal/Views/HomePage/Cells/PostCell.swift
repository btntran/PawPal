//
//  PostCell.swift
//  PawPal
//
//  Created by Minh Nguyen on 11/26/24.
//

import UIKit

class PostCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    func configure(with post: Post) {
        avatarImageView.image = post.avatar
        titleLabel.text = post.title
        bodyLabel.text = post.body
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.cornerRadius = 8.0
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4.0
        contentView.layer.masksToBounds = false
    }
}
