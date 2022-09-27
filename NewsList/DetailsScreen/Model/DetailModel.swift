//
//  DetailModel.swift
//  NewsList
//
//  Created by Serhii Palamarchuk on 27.09.2022.
//

import Foundation

struct DetailModel: Codable {
    let post: Post
}

struct Post: Codable {
    let postID, timeshamp: Int
    let title, text: String
    let postImage: String
    let likesCount: Int

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case timeshamp, title, text, postImage
        case likesCount = "likes_count"
    }
}
