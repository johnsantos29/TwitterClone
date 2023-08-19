//
//  ProfileDataFormViewViewModel.swift
//  TwitterClone
//
//  Created by John Erick Santos on 16/8/2023.
//

import Combine
import FirebaseStorage
import Foundation
import UIKit

final class ProfileDataFormViewViewModel: ObservableObject {
    private var subscriptions: Set<AnyCancellable> = []

    @Published var displayName: String?
    @Published var username: String?
    @Published var bio: String?
    @Published var avatarPath: String?
    @Published var imageData: UIImage?
    @Published var isFormValid: Bool = false
    @Published var url: URL?
    @Published var error: String = ""

    func validateUserProfileForm() {
        guard let displayName = displayName,
              let username = username,
              let bio = bio,
              displayName.count > 2,
              username.count > 2,
              bio.count > 2,
              imageData != nil
        else {
            isFormValid = false
            return
        }

        isFormValid = true
    }

    func uploadAvatar() {
        let randomID = UUID().uuidString
        guard let imageData = imageData?.jpegData(compressionQuality: 0.5) else { return }
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        StorageManager.shared.uploadProfilePhoto(with: randomID, image: imageData, metadata: metadata)
            .flatMap { metadata in
                StorageManager.shared.getDownloadURL(for: metadata.path)
            }
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { [weak self] url in
                self?.url = url
            }
            .store(in: &subscriptions)
    }
}
