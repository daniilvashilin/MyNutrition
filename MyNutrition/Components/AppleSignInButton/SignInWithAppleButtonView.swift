//
//  SignInWithAppleButtonView.swift
//  MyNutrition
//
//  Created by Daniil on 26/12/2024.
//

import Foundation
import SwiftUI
import AuthenticationServices


struct SignInWithAppleButtonView: View {
    let onCompletion: (Result<ASAuthorization, Error>) -> Void

    var body: some View {
        SignInWithAppleButton(
            .signIn,
            onRequest: { request in
                request.requestedScopes = [.fullName, .email]
            },
            onCompletion: { result in
                switch result {
                case .success(let authResults):
                    onCompletion(.success(authResults))
                case .failure(let error):
                    onCompletion(.failure(error))
                }
            }
        )
        .signInWithAppleButtonStyle(.black)
        .frame(height: 40)
        .padding()
    }
}
