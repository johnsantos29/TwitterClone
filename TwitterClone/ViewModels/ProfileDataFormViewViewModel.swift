//
//  ProfileDataFormViewViewModel.swift
//  TwitterClone
//
//  Created by John Erick Santos on 16/8/2023.
//

import Combine
import Foundation

final class ProfileDataFormViewViewModel: ObservableObject {
    @Published var displayName: String?
    @Published var username: String?
    @Published var bio: String?
    @Published var avatarPath: String?
}
