//
//  TwitterUser.swift
//  TwitterClone
//
//  Created by John Erick Santos on 16/8/2023.
//

import Firebase
import Foundation

struct TwitterUser: Codable {
    let id: String
    var displayName: String = ""
    var username: String = ""
    var followersCount: Double = 0
    var followingCount: Double = 0
    var createdOn: Date = .init()
    var bio: String = ""
    var avatarPath: String = ""
    var isUserOnboarded: Bool = false

    init(from user: User) {
        self.id = user.uid
    }
}
