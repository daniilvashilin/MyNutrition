//
//  ReadyScreenView.swift
//  MyNutrition
//
//  Created by Daniil on 17/12/2024.
//

import SwiftUI

struct ReadyLoginScreenView: View {
    @ObservedObject var viewModel: BaseAuthViewModel
    var topTextFont: Font
    var underTopTextFormFont: Font
    @State private var showRegisterScreen = false
    var showLogo: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backGround
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 15) {
                    Spacer()
                    
                    // Логотип
                    Image(showLogo ? "LogoIcon" : "NoImage")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(.text)
                        .frame(width: 50, height: 50)
                    
                    // Заголовок и подзаголовок
                    Text("Welcome to MyNutrition")
                        .font(topTextFont)
                        .fontWeight(.medium)
                        .foregroundStyle(.text)
                    
                    Text("Enter your email and password or access your account")
                        .font(underTopTextFormFont)
                        .foregroundStyle(.subText)
                        .padding(.bottom, 10)
                    
                    // Поля ввода
                    CustomTextFiledVIew(
                        width: 300,
                        height: 45,
                        text: $viewModel.email,
                        viewModel: viewModel
                    )
                    .padding(.bottom, 10)
                    
                    CustomSecurFieldView(
                        width: 300,
                        height: 45,
                        text: $viewModel.password,
                        viewModel: viewModel
                    )
                    .padding(.bottom, 20)
                    
                    // Кнопки
                    Button {
                        print("Sign in tapped")
                        Task {
                            do {
                                try await viewModel.signInWithEmail()
                            } catch {
                                print("Login failed: \(String(describing: viewModel.errorMessage))")
                            }
                        }
                    } label: {
                        Text("Sign in")
                    }
                    .getCustomButtonStyle(width: 300, height: 45, textColor: .secondText, backGroundColor: .text, cornerRadius: 15)
                    
                    Button(action: {
                        showRegisterScreen = true
                    }) {
                        Text("Register")
                    }
                    .getCustomButtonStyle(width: 300, height: 40, textColor: .text, backGroundColor: .textField, cornerRadius: 10)
                    .sheet(isPresented: $showRegisterScreen) {
                        FinalRegisterScreenView()
                    }
                    Button {
                        print("Sign in with Apple")
                    } label: {
                        HStack {
                            Image(systemName: "apple.logo")
                                .font(.headline)
                            Text("Sign in with Apple")
                        }
                    }
                    .getCustomButtonStyle(width: 300, height: 40, textColor: .text, backGroundColor: .backGround, cornerRadius: 10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.text, lineWidth: 2)
                    )
                    
                    Spacer()
                    
                    // Текст помощи
                    Text("Need help ? visit support page 􀬂")
                        .foregroundStyle(.subText)
                        .font(.footnote)
                }
                .padding()
            }
        }
    }
}
