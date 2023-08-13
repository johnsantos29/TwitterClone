//
//  AuthManager.swift
//  TwitterClone
//
//  Created by John Erick Santos on 13/8/2023.
//

import Combine
import Firebase
import FirebaseAuthCombineSwift
import Foundation

class AuthManager {
    static let shared = AuthManager()

    func registerUser(with email: String, password: String) -> AnyPublisher<User, Error> {
        return Auth.auth().createUser(withEmail: email, password: password)
            .map(\.user)
            .eraseToAnyPublisher()
    }
}
