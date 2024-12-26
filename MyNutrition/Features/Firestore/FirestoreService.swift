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
    func createOrUpdateUser(user: User, completion: @escaping (Result<Void, Error>) -> Void) {
        guard !user.id.isEmpty else {
            completion(.failure(NSError(domain: "FirestoreService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid UID"])))
            return
        }
        do {
            try db.collection("users").document(user.id).setData(from: user, merge: true)
            completion(.success(()))
        } catch {
            print("Error creating/updating user: \(error.localizedDescription)")
            completion(.failure(error))
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
