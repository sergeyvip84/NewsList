//
//  DataJsonFirstScreen.swift
//  NewsList
//
//  Created by Serhii Palamarchuk on 26.09.2022.
//

import Foundation

struct CommentsModel: Codable {
     var posts = [Post]()
}

struct Post: Codable {
    let postID, timeshamp: Int
    let title, previewText: String
    let likesCount: Int

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case timeshamp, title
        case previewText = "preview_text"
        case likesCount = "likes_count"
    }
}

