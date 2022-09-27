//
//  DetailViewController.swift
//  NewsList
//
//  Created by Serhii Palamarchuk on 27.09.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var postID = 0
    var detailMode = [DetailModel]()
    
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        receiveArray()
    }
    
    func receiveArray() {
        NetworkJsonManager.fetchJson(urlString: (urlInfoScreen + String(postID) + ".json"), type: DetailModel.self) { json in
            self.detailMode.append(json)
            DispatchQueue.main.async {
                DataProvider.share.downloadImage(url: self.detailMode[0].post.postImage) { [weak self] image in
                    self?.image.image = image
                }
            }
        }
    }
}
