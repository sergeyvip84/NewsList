//
//  ViewController.swift
//  NewsList
//
//  Created by Serhii Palamarchuk on 26.09.2022.
//

import UIKit

class CommentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var timeNow = Int(NSDate().timeIntervalSince1970)
    
    var comments = CommentsModel()
    var activityButtomSorted = false
    
    @IBOutlet weak var buttomSorted: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        receiveArray()
    }
    
    func receiveArray() {
        NetworkJsonManager.fetchJson(urlString: urlComment, type: CommentsModel.self) { json in
            self.comments = json
            self.comments.posts.sort { $0.timeshamp > $1.timeshamp }
            
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
        cell.timeNow = timeNow
        cell.configure(with: comment)
        cell.laberComment.numberOfLines = comment.expandeCell ? 0 : 2
        cell.buttom.setTitle(comment.expandeCell ? "Collapse" : "Expande", for: .normal)
        
        cell.actionHandler = { [weak self] cell in
            DispatchQueue.main.async {
                self?.comments.posts[cell.indexCell].expandeCell = !(self?.comments.posts[cell.indexCell].expandeCell)!
                self?.tableView.reloadData()
            }
        }
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
    
    
    @IBAction func buttomSorted(_ sender: Any) {
        if !activityButtomSorted {
            activityButtomSorted = true
            buttomSorted.tintColor = .red
            comments.posts.sort { $0.likesCount > $1.likesCount }
        } else {
            activityButtomSorted = false
            buttomSorted.tintColor = .gray
            self.comments.posts.sort { $0.timeshamp > $1.timeshamp }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

