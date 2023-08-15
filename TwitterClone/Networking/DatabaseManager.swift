//
//  DatabaseManager.swift
//  TwitterClone
//
//  Created by John Erick Santos on 16/8/2023.
//

import Combine
import Firebase
import FirebaseFirestoreCombineSwift
import FirebaseFirestoreSwift
import Foundation

final class DatabaseManager {
    static let shared = DatabaseManager()

    let db = Firestore.firestore()
    let usersPath: String = "users"

    func collectionUsers(add user: User) -> AnyPublisher<Bool, Error> {
        let twitterUser = TwitterUser(from: user)

        return db.collection(usersPath).document(twitterUser.id).setData(from: twitterUser)
            .map { _ in
                true
            }
            .eraseToAnyPublisher()
    }

    func collectionUsers(retrieve id: String) -> AnyPublisher<TwitterUser, Error> {
        db.collection(usersPath).document(id).getDocument()
            .tryMap {
                try $0.data(as: TwitterUser.self)
            }
            .eraseToAnyPublisher()
    }
}
