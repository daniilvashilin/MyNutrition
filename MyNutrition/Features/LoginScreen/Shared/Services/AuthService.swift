//
//  AuthService.swift
//  MyNutrition
//
//  Created by Daniil on 17/12/2024.
//

import Foundation
import FirebaseAuth
import AuthenticationServices
import CryptoKit
import FirebaseFirestore

final class AuthService: ObservableObject {
    private var currentNonce: String?
    static let shared = AuthService()
    
    func signInWithApple(credential: ASAuthorizationAppleIDCredential, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        // Generate nonce
        let nonce = generateNonce()
        currentNonce = nonce
        
        guard let identityToken = credential.identityToken,
              let tokenString = String(data: identityToken, encoding: .utf8) else {
            completion(.failure(NSError(domain: "SignInWithApple", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid Token"])))
            return
        }
        
        let hashedNonce = sha256(nonce)
        
        let firebaseCredential = OAuthProvider.credential(
            providerID: AuthProviderID.apple,
            idToken: tokenString,
            rawNonce: hashedNonce,
            accessToken: nil // If nonce not needed
        )
        
        Auth.auth().signIn(with: firebaseCredential) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let authResult = authResult {
                completion(.success(authResult))
            }
        }
    }
    struct AuthDataResultModel {
        let uid: String
        let email: String?
        let photoURL: String?
        
        init(user: User) {
            self.email = user.email
            self.photoURL = user.photoURL?.absoluteString
            self.uid = user.uid
        }
    }
    func signInWithEmail(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        let user = authDataResult.user
        
        // Link to collection `users`
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(user.uid)
        
        // Is user excist in Firestore ?
        let document = try await userRef.getDocument()
        
        if document.exists {
            // If true the update lastLoginAt
            try await userRef.updateData(["lastLoginAt": FieldValue.serverTimestamp()])
        } else {
            // If false create a new lastLoginAt
            let userData: [String: Any] = [
                "uid": user.uid,
                "email": user.email ?? "",
                "name": "No Name", // Или добавить поле для имени пользователя
                "createdAt": FieldValue.serverTimestamp(),
                "lastLoginAt": FieldValue.serverTimestamp(),
                "isPremium": false
            ]
            try await userRef.setData(userData)
        }
        
        return AuthDataResultModel(user: user)
    }
    // Register
    func createUserWithEmail(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        let user = authDataResult.user
        
        // Создаём документ в коллекции `users`
        let firestoreUser = FirestoreService.User(
            id: user.uid,
            email: user.email,
            name: "No Name",
            photoURL: nil,
            providerId: "password",
            createdAt: Date(),
            isPremium: false,
            lastLoginAt: Date()
        )
        try await FirestoreService.shared.createOrUpdateUserAsync(user: firestoreUser)
        
        let nutritionData: [String: Any] = [
            "current": [
                "caloriesConsumed": 0,
                "proteinConsumed": 0,
                "fatConsumed": 0,
                "carbsConsumed": 0,
                "sugarConsumed": 0,
                "fiberConsumed": 0,
                "move": 0,
                "exerciseMinutes": 0,
                "steps": 0
            ],
            
            "history": [],
            
            "caloriesGoal": 0,
            "proteinGoal": 0,
            "fatGoal": 0,
            "carbsGoal": 0,
            "sugarGoal": 0,
            "fiberGoal": 0,
            "weightGoal": 0,
            
            "lastResetDate": "",
            "ownerId": user.uid
        ]
        let db = Firestore.firestore()
        try await db.collection("nutrition").document(user.uid).setData(nutritionData)
        
        return AuthDataResultModel(user: user)
    }
    // Other
    func signOut() throws {
        guard Auth.auth().currentUser != nil else {
            print("Пользователь не авторизован")
            return
        }
        try Auth.auth().signOut()
    }
    
    func deleteUserAccount() async {
        guard let currentUser = Auth.auth().currentUser else {
            print("Ошибка: пользователь не авторизован")
            return
        }
        
        let db = Firestore.firestore()
        
        do {
            try await db.collection("users").document(currentUser.uid).delete()
            print("Данные пользователя удалены из Firestore")
        } catch {
            print("Ошибка при удалении данных из Firestore: \(error.localizedDescription)")
            return
        }
        
        do {
            try await currentUser.delete()
            print("Пользователь удалён из Firebase Authentication")
        } catch {
            print("Ошибка при удалении аккаунта из Firebase Authentication: \(error.localizedDescription)")
        }
    }
    
    func deleteRelatedData(for uid: String) async throws {
        let db = Firestore.firestore()
        let nutritionRef = db.collection("nutrition").whereField("ownerId", isEqualTo: uid)
        
        let documents = try await nutritionRef.getDocuments()
        for document in documents.documents {
            try await document.reference.delete()
        }
    }
    
    func reauthenticateUser(email: String, password: String) async throws {
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        guard let currentUser = Auth.auth().currentUser else { return }
        
        try await currentUser.reauthenticate(with: credential)
        print("Пользователь успешно переавторизован")
    }
    
    
    
    func generateNonce(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode == errSecSuccess {
                    return random
                } else {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    func resetDailyDataIfNeeded(uid: String) async throws {
        let db = Firestore.firestore()
        let nutritionRef = db.collection("nutrition").document(uid)
        
        let today = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
        
        let document = try await nutritionRef.getDocument()
        if var data = document.data() {
            let lastResetDate = data["lastResetDate"] as? String ?? ""
            
            if today != lastResetDate {
                var currentData = data["current"] as? [String: Any] ?? [:]
                var history = data["history"] as? [[String: Any]] ?? []
                
                currentData["date"] = today
                history.append(currentData)
                
                data["history"] = history
                data["current"] = [
                    "caloriesConsumed": 0,
                    "proteinConsumed": 0,
                    "fatConsumed": 0,
                    "carbsConsumed": 0,
                    "sugarConsumed": 0,
                    "fiberConsumed": 0,
                    "move": 0,
                    "exerciseMinutes": 0,
                    "steps": 0
                ]
                data["lastResetDate"] = today
                
                try await nutritionRef.setData(data, merge: true)
            }
        }
    }
    
    func updateCurrentNutrition(uid: String, updates: [String: Any]) async throws {
        let db = Firestore.firestore()
        let nutritionRef = db.collection("nutrition").document(uid)
        
        for (key, value) in updates {
            guard let incrementValue = value as? Int else { continue }
            try await nutritionRef.updateData([
                "current.\(key)": FieldValue.increment(Int64(incrementValue))
            ])
        }
    }
    
    
    func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        return hashedData.compactMap { String(format: "%02x", $0) }.joined()
    }
}


extension AuthService {
    func addUserToFirestore(user: User) async throws {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(user.uid)
        
        // Подготовка данных для Firestore
        let userData: [String: Any] = [
            "uid": user.uid,
            "email": user.email ?? "",
            "name": "No Name",
            "createdAt": FieldValue.serverTimestamp(),
            "isPremium": false,
        ]
        
        // Добавление данных в Firestore
        try await userRef.setData(userData, merge: true)
    }
}
