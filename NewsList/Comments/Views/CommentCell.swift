//
//  CommentCell.swift
//  NewsList
//
//  Created by Serhii Palamarchuk on 27.09.2022.
//

import UIKit

class CommentCell: UITableViewCell {
    
    var timeNow = 0
    var indexCell = 0
    
    var actionHandler: ((CommentCell) -> Void)?
    
    @IBOutlet weak var labelLikes: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var laberComment: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var buttom: UIButton! {
        didSet {
            buttom.layer.cornerRadius = 10
            buttom.layer.shadowOffset = CGSize(width: 0, height: 5)
            buttom.layer.shadowOpacity = 0.8
            buttom.layer.shadowRadius = 10
        }
    }
    
    @IBAction func buttomTap(_ sender: UIButton) {
        
        actionHandler?(self)
    }
    
    func configure(with comment: Posts) {
        self.label.text = comment.title
        self.laberComment.text = comment.previewText
        self.labelTime.text = String(Int((timeNow - comment.timeshamp) / 86400)) + " day ago"
        self.labelLikes.text = String(comment.likesCount)
    }
}

