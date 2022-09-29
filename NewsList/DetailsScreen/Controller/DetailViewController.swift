//
//  DetailViewController.swift
//  NewsList
//
//  Created by Serhii Palamarchuk on 27.09.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var postID = 0
    
    @IBOutlet weak var likeHearth: UIImageView!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelLikes: UILabel!
    @IBOutlet weak var labelComment: UITextView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var activitiIndicator: UIActivityIndicatorView!
    @IBOutlet weak var image: UIImageView! {
        didSet {
            image.layer.shadowOffset = CGSize(width: 0, height: 5)
            image.layer.shadowOpacity = 0.8
            image.layer.shadowRadius = 15
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        receiveArray()
    }
    
    func receiveArray() {
        showLoader(loader: activitiIndicator, show: true)
        
        NetworkJsonManager.fetchJson(urlString: (urlInfoScreen + String(postID) + ".json"), type: DetailModel.self) { json in
            
            DispatchQueue.main.async { [self] in
                
                self.likeHearth.isHidden = false
                self.labelTime.text = createDateTime(timestamp: json.post.timeshamp)
                self.labelLikes.text = String(json.post.likesCount)
                self.labelComment.text = json.post.text
                self.label.text = json.post.title
                
                DataProvider.share.downloadImage(url: json.post.postImage) { [weak self] image in
                    
                    self?.image.image = image
                    showLoader(loader: self!.activitiIndicator, show: false)
                }
            }
        }
    }
    
    func createDateTime(timestamp: Int) -> String {
        var strDate = "undefined"
        
        let unixTime = Double(timestamp)
        let date = Date(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        let timezone = TimeZone.current.abbreviation() ?? "CET"
        dateFormatter.timeZone = TimeZone(abbreviation: timezone)
        dateFormatter.locale = Locale(identifier: "en_US")
        
        dateFormatter.dateFormat = "d MMMM yyyy"
        strDate = dateFormatter.string(from: date)
        
        return strDate
    }
}
