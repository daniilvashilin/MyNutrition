//
//  ReadyScreenView.swift
//  MyNutrition
//
//  Created by Daniil on 17/12/2024.
//

import SwiftUI

struct ReadyScreenView: View {
    @ObservedObject var viewModel: BaseAuthViewModel
    var body: some View {
        VStack(spacing: 15) {
            Spacer()
            Text("Welcome to MyNutrition")
                .font(.largeTitle)
                .fontWeight(.medium)
                .foregroundStyle(.text)
            
            Text("Enter your email and password or access your account")
                .font(.title2)
                .foregroundStyle(.subText)
                .padding(.bottom, 10)
            
            CustomTextFiledVIew(width: 350, height: 50, viewModel: viewModel)
                .padding(.bottom, 10)
            
            CustomSecurFieldView(width: 350, height: 50, viewModel: viewModel)
                .padding(.bottom, 20)
            
            Button {
                print("Sign in tapped")
            } label: {
                Text("Sign in")
            }
            .getCustomButtonStyle(width: 350, height: 50, textColor: .white, backGroundColor: .black, cornerRadius: 15)
            
            Button {
                print("Register tapped")
            } label: {
                Text("Register")
            }
            .getCustomButtonStyle(width: 350, height: 50, textColor: .black, backGroundColor: .gray, cornerRadius: 15)
            
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
