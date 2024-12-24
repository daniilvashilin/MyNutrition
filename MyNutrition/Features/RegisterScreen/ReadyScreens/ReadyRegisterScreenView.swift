//
//  ReadyRegisterScreenView.swift
//  MyNutrition
//
//  Created by Daniil on 24/12/2024.
//

import SwiftUI

struct ReadyRegisterScreenView: View {
    @ObservedObject var viewModel: BaseAuthViewModel
    var topTextFont: Font
    var underTopTextFormFont: Font
    var showLogo: Bool
    
    var body: some View {
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
            
            Button {
                print("Sign in with Apple")
            } label: {
                HStack {
                    Image(systemName: "apple.logo")
                        .font(.headline)
                    Text("Sign in with Apple")
                }
            }
            .getCustomButtonStyle(width: formWidth, height: 40, textColor: .black, backGroundColor: .white, cornerRadius: 10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.text, lineWidth: 2)
            )
            
            Spacer()
            
            Text("Need help ? visit support page 􀬂")
                .foregroundStyle(.subText)
                .font(.footnote)
        }
        .padding()
        .background(Color.backGround.edgesIgnoringSafeArea(.all))
    }
    
    private var formWidth: CGFloat {
        UIScreen.main.bounds.width <= 375 ? 300 : 350
    }
}
