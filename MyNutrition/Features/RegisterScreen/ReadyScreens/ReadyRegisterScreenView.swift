//
//  ReadyRegisterScreenView.swift
//  MyNutrition
//
//  Created by Daniil on 24/12/2024.
//

import SwiftUI
import AuthenticationServices

struct ReadyRegisterScreenView: View {
    @ObservedObject var viewModel: BaseAuthViewModel
    @ObservedObject var authService: AuthService
    var topTextFont: Font
    var underTopTextFormFont: Font
    var showLogo: Bool
    
    @State private var isAuthenticated = false // Состояние для навигации
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                Spacer()
                Text("Welcome to MyNutrition")
                    .font(topTextFont)
                    .fontWeight(.medium)
                    .foregroundStyle(.text)
                
                Text("Enter your email and password or access your account")
                    .font(underTopTextFormFont)
                    .foregroundStyle(.subText)
                    .padding(.bottom, 10)
                
                // Поля ввода
                CustomTextFiledVIew(width: formWidth, height: 45, text: $viewModel.email, viewModel: viewModel)
                    .padding(.bottom, 10)
                
                CustomSecurFieldView(width: formWidth, height: 45, text: $viewModel.password, viewModel: viewModel)
                    .padding(.bottom, 20)
                
                CustomSecurFieldView(width: formWidth, height: 45, text: $viewModel.passwordConfirmation, viewModel: viewModel)
                    .padding(.bottom, 20)
                
                Button {
                    print("Register tapped")
                    Task {
                        do {
                            try await viewModel.registerWithEmail()
                        } catch {
                            print("Register failed: \(String(describing: viewModel.errorMessage))")
                        }
                    }
                } label: {
                    Text("Register")
                }
                .getCustomButtonStyle(width: formWidth, height: 45, textColor: .white, backGroundColor: .black, cornerRadius: 15)
                
                SignInWithAppleButtonView { result in
                    switch result {
                    case .success(let authorization):
                        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                            AuthService.shared.signInWithApple(credential: appleIDCredential) { result in
                                switch result {
                                case .success(let authResult):
                                    print("Пользователь авторизован: \(authResult.user.uid)")
                                    DispatchQueue.main.async {
                                        isAuthenticated = true // Устанавливаем состояние навигации
                                    }
                                case .failure(let error):
                                    print("Ошибка авторизации: \(error.localizedDescription)")
                                }
                            }
                        } else {
                            print("Неверный тип данных авторизации")
                        }
                    case .failure(let error):
                        print("Ошибка авторизации через Apple: \(error.localizedDescription)")
                    }
                }
                
                Spacer()
                
                Text("Need help ? visit support page 􀬂")
                    .foregroundStyle(.subText)
                    .font(.footnote)
            }
            .padding()
            .background(Color.backGround.edgesIgnoringSafeArea(.all))
            .navigationDestination(isPresented: $isAuthenticated) {
                TestHomePageView(viewModel: viewModel, authservice: authService) // Переход на экран TestHomePageView
            }
        }
    }
    
    private var formWidth: CGFloat {
        UIScreen.main.bounds.width <= 375 ? 300 : 350
    }
}
