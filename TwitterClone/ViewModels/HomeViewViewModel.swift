//
//  HomeViewViewModel.swift
//  TwitterClone
//
//  Created by John Erick Santos on 16/8/2023.
//

import Combine
import FirebaseAuth
import Foundation

final class HomeViewViewModel: ObservableObject {
    private var subscriptions: Set<AnyCancellable> = []

    @Published var user: TwitterUser?
    @Published var error: String?

    func retrieveUser() {
        guard let id = Auth.auth().currentUser?.uid else { return }

        DatabaseManager.shared.collectionUsers(retrieve: id)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] user in
                self?.user = user
            }.store(in: &subscriptions)
    }
}
