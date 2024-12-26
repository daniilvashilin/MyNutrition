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

final class AuthService: ObservableObject {
    private var currentNonce: String?
    static let shared = AuthService()
    
    func signInWithApple(credential: ASAuthorizationAppleIDCredential, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        // Генерация nonce
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
            accessToken: nil // Если accessToken не требуется
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
        return AuthDataResultModel(user: authDataResult.user)
    }
    func singInWithGoogle() {
        
    }
    // Register
    func createUserWithEmail(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func createUserWithGoogle() {
        
    }
    // Other
    func signOut() throws {
        try Auth.auth().signOut()
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
    
    func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        return hashedData.compactMap { String(format: "%02x", $0) }.joined()
    }
}
