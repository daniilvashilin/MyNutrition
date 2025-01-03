import Foundation
import FirebaseFirestore
import FirebaseAuth


class FirestoreService {
    static let shared = FirestoreService() // Singleton

    private let db = Firestore.firestore()
    
    struct User: Codable, Identifiable {
        var id: String
        var email: String?
        var name: String?
        var photoURL: String?
        var providerId: String
        var createdAt: Date
        var isPremium: Bool
        var lastLoginAt: Date?
        var termsAccepted: Bool
        var privacyPolicyAccepted: Bool
        var healthDataAccessGranted: Bool
        var locationAccessGranted: Bool
        var analyticsOptIn: Bool
    }
    
    func createOrUpdateUserAsync(user: User) async throws {
        let userRef = db.collection("users").document(user.id)
        do {
            try userRef.setData(from: user, merge: true)
        } catch {
            throw NSError(domain: "FirestoreService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unable to create or update user: \(error.localizedDescription)"])
        }
    }

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
