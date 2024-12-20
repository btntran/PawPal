//
//  CommunityTableCell.swift
//  PawPal
//
//  Created by Khang Nguyen on 11/16/24.
//

import UIKit

class CommunityTableCell: UITableViewCell {

    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellDescription: UILabel!
    @IBOutlet weak var cellNumComment: UILabel!
    @IBOutlet weak var cellNumReaction: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTitle(title: String){
        self.cellTitle.text = title
    }
    
    func setDescription(description: String){
        self.cellDescription.text = description
    }
    
    func setNumComment(numComment: Int){
        self.cellNumComment.text = String(numComment)
    }
    
    func setNumReaction(numReaction: Int){
        self.cellNumReaction.text = String(numReaction)
    }
}
