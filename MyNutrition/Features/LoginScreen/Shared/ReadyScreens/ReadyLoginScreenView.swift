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
    var showLogo: Bool
    var body: some View {
            if UIScreen.main.bounds.width <= 375 {
                VStack(spacing: 15) {
                    Spacer()
                    Image(showLogo == true ? "LogoIcon" : "NoImage")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(.text)
                        .frame(width: 50, height: 50)
                    Text("Welcome to MyNutrition")
                        .font(topTextFont)
                        .fontWeight(.medium)
                        .foregroundStyle(.text)
                    
                    Text("Enter your email and password or access your account")
                        .font(underTopTextFormFont)
                        .foregroundStyle(.subText)
                        .padding(.bottom, 10)
                    
                    CustomTextFiledVIew(width: 300, height: 45, text: $viewModel.email, viewModel: viewModel)
                        .padding(.bottom, 10)
                    
                    CustomSecurFieldView(width: 300, height: 45, text: $viewModel.password, viewModel: viewModel)
                        .padding(.bottom, 20)
                    
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
                    .getCustomButtonStyle(width: 300, height: 45, textColor: .white, backGroundColor: .black, cornerRadius: 15)
                    
                    NavigationLink(destination: {
                        IPadRegisterScreenView()
                    }, label: {
                        Text("Register")
                    })
                    .getCustomButtonStyle(width: 300, height: 40, textColor: .text, backGroundColor: .textField, cornerRadius: 10)
                    
                    Button {
                        print("Sign in with Apple")
                    } label: {
                        HStack {
                            Image(systemName: "apple.logo")
                                .font(.headline)
                            Text("Sign in with Apple")
                        }
                    }
                    .getCustomButtonStyle(width: 300, height: 40, textColor: .black, backGroundColor: .white, cornerRadius: 10)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.text, lineWidth: 2)
                    )
                    Spacer()
                    
                    Text("Need help ? visit support page 􀬂")
                        .foregroundStyle(.subText)
                        .font(.footnote)
                    
                }
                .padding()
                
                
            } else {
                VStack(spacing: 15) {
                    Spacer()
                    Image(showLogo == true ? "LogoIcon" : "NoImage")
                        .renderingMode(.template)
                        .foregroundStyle(.text)
                    Text("Welcome to MyNutrition")
                        .font(topTextFont)
                        .fontWeight(.medium)
                        .foregroundStyle(.text)
                    
                    Text("Enter your email and password or access your account")
                        .font(underTopTextFormFont)
                        .foregroundStyle(.subText)
                        .padding(.bottom, 10)
                    
                    CustomTextFiledVIew(width: 350, height: 50, text: $viewModel.email, viewModel: viewModel)
                        .padding(.bottom, 10)
                    
                    CustomSecurFieldView(width: 350, height: 50, text: $viewModel.password, viewModel: viewModel)
                        .padding(.bottom, 20)
                    
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
                    .getCustomButtonStyle(width: 350, height: 50, textColor: .white, backGroundColor: .black, cornerRadius: 15)
                    
                    Button {
                        print("Register tapped")
                    } label: {
                        Text("Register")
                    }
                    .getCustomButtonStyle(width: 350, height: 50, textColor: .text, backGroundColor: .textField, cornerRadius: 15)
                    
                    Button {
                        print("Sign in with Apple")
                    } label: {
                        HStack {
                            Image(systemName: "apple.logo")
                                .font(.headline)
                            Text("Sign in with Apple")
                        }
                    }
                    .getCustomButtonStyle(width: 350, height: 50, textColor: .black, backGroundColor: .white, cornerRadius: 15)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.black, lineWidth: 2)
                    )
                    Spacer()
                    
                    Text("Need help ? visit support page 􀬂")
                        .foregroundStyle(.subText)
                        .font(.footnote)
                }
                .padding()
            }
        }
}
