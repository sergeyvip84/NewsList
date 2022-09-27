//
//  CommentCell.swift
//  NewsList
//
//  Created by Serhii Palamarchuk on 27.09.2022.
//

import UIKit

class CommentCell: UITableViewCell {
    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var laberComment: UILabel!
    @IBOutlet weak var buttom: UIButton!
    
    func configure(with comment: Post) {
        self.label.text = comment.title
        self.laberComment.text = comment.previewText
    }
}

