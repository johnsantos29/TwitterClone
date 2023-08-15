//
//  AuthenticationViewViewModel.swift
//  TwitterClone
//
//  Created by John Erick Santos on 13/8/2023.
//

import Combine
import Firebase
import Foundation

final class AuthenticationViewViewModel: ObservableObject {
    private var subscriptions: Set<AnyCancellable> = []

    @Published var email: String?
    @Published var password: String?
    @Published var isAuthenticationFormValid: Bool = false
    @Published var user: User?
    @Published var error: String?

    func validateAuthenticationForm() {
        guard let email = email, let password = password else {
            return
        }

        isAuthenticationFormValid = isValidEmail(email) && password.count >= 8
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    func createUser() {
        guard let email = email, let password = password else { return }

        AuthManager.shared.registerUser(with: email, password: password)
            .handleEvents(receiveOutput: { [weak self] user in
                self?.user = user
            })
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] user in
                self?.createRecord(for: user)
            }.store(in: &subscriptions)
    }

    private func createRecord(for user: User) {
        DatabaseManager.shared.collectionUsers(add: user)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { state in
                print("Adding user record to database: \(state)")
            }
            .store(in: &subscriptions)
    }

    func loginUser() {
        guard let email = email, let password = password else { return }

        AuthManager.shared.loginUser(with: email, password: password)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] user in
                self?.user = user
            }.store(in: &subscriptions)
    }
}
