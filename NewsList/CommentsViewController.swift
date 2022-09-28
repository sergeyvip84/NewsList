//
//  ViewController.swift
//  NewsList
//
//  Created by Serhii Palamarchuk on 26.09.2022.
//

import UIKit

class CommentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var comments = CommentsModel()
    
    @IBOutlet weak var tableView: UITableView!
    
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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CommentCell
        let comment = comments.posts[indexPath.row]
        cell.indexCell = indexPath.row
        cell.configure(with: comment)
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let detail = segue.destination as! DetailViewController
            let cell = sender as! CommentCell
            detail.postID = comments.posts[cell.indexCell].postID
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}



