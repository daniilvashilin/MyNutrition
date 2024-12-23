//
//  AuthService.swift
//  MyNutrition
//
//  Created by Daniil on 17/12/2024.
//

import Foundation
import FirebaseAuth


final class AuthService: ObservableObject {
    
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
}
