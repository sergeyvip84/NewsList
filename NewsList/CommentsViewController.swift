//
//  ViewController.swift
//  NewsList
//
//  Created by Serhii Palamarchuk on 26.09.2022.
//

import UIKit

class CommentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var comments = CommentsModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        receiveArray()
    }
    
    func receiveArray() {
        NetworkJsonManager.fetchJson(urlString: urlComment, type: CommentsModel.self) { json in
            self.comments = json
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
              
            }
        }
//        NetworkJsonManager.fetchJson(urlString: urlEquipment, type: ArrayEquipment.self) { arrayEquipment in
//            self.arrayEquipment = arrayEquipment
//            self.doArrayToDetail()
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CommentCell
        let comment = comments.posts[indexPath.row]
        cell.configure(with: comment)
        return cell
    }

}



