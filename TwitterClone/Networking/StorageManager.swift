//
//  StorageManager.swift
//  TwitterClone
//
//  Created by John Erick Santos on 19/8/2023.
//

import Combine
import FirebaseStorage
import FirebaseStorageCombineSwift
import Foundation

enum FirestorageError: Error {
    case invalidImageID
}

final class StorageManager {
    static let shared = StorageManager()

    let storage = Storage.storage()

    func uploadProfilePhoto(with randomID: String, image: Data, metadata: StorageMetadata) -> AnyPublisher<StorageMetadata, Error> {
        return storage
            .reference()
            .child("images/\(randomID)")
            .putData(image, metadata: metadata)
            .print()
            .eraseToAnyPublisher()
    }

    func getDownloadURL(for id: String?) -> AnyPublisher<URL, Error> {
        guard let id = id else {
            return Fail(error: FirestorageError.invalidImageID)
                .eraseToAnyPublisher()
        }

        return storage
            .reference(withPath: id)
            .downloadURL()
            .print()
            .eraseToAnyPublisher()
    }
}
