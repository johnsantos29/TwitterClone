//
//  ProfileDataFormViewViewModel.swift
//  TwitterClone
//
//  Created by John Erick Santos on 16/8/2023.
//

import Combine
import Foundation
import UIKit

final class ProfileDataFormViewViewModel: ObservableObject {
    @Published var displayName: String?
    @Published var username: String?
    @Published var bio: String?
    @Published var avatarPath: String?
    @Published var imageData: UIImage?
    @Published var isFormValid: Bool = false
    
    func validateUserProfileForm() {
        guard let displayName = displayName,
              let username = username,
              let bio = bio,
              displayName.count > 2,
              username.count > 2,
              bio.count > 2,
              imageData != nil else {
            isFormValid = false
            return
        }
        
        isFormValid = true
    }
}
