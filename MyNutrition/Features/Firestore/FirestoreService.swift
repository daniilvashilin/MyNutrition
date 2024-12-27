//
//  FirestoreService.swift
//  MyNutrition
//
//  Created by Daniil on 26/12/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth


class FirestoreService {
    static let shared = FirestoreService() // Singleton

    private let db = Firestore.firestore()
    
    struct User: Codable, Identifiable {
        var id: String // uid из Firebase Authentication
        var email: String? // Почта, если есть
        var name: String? // Имя пользователя, если предоставлено
        var photoURL: String? // Ссылка на аватар, если доступна
        var providerId: String // Способ авторизации (например, "password", "apple.com")
        var createdAt: Date // Дата регистрации
        var isPremium: Bool // Дополнительное поле: премиум-статус
        var lastLoginAt: Date? // Последний вход
    }
    // Создание или обновление пользователя
    func createOrUpdateUserAsync(user: User) async throws {
        let userRef = db.collection("users").document(user.id)
        do {
            try userRef.setData(from: user, merge: true)
        } catch {
            throw NSError(domain: "FirestoreService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to create or update user: \(error.localizedDescription)"])
        }
    }

    // Получение данных пользователя
    func fetchUser(uid: String, completion: @escaping (Result<User, Error>) -> Void) {
        db.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot, let user = try? snapshot.data(as: User.self) {
                completion(.success(user))
            } else {
                completion(.failure(NSError(domain: "Firestore", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not found"])))
            }
        }
    }

    // Пример: Удаление пользователя
    func deleteUser(uid: String, completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection("users").document(uid).delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
