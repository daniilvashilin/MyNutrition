//
//  CustomSecurFieldView.swift
//  MyNutrition
//
//  Created by Daniil on 17/12/2024.
//

import Foundation
import SwiftUI

struct CustomSecurFieldView: View {
    var width: CGFloat
    var height: CGFloat
    var headlineText: String = "Password"
    @ObservedObject var viewModel: BaseAuthViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(headlineText)
                .fontWeight(.medium)
            SecureField("Enter password", text: $viewModel.password)
                .padding()
                .frame(width: width, height: height)
                .background(Color(.textField))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .foregroundStyle(.text)
        }
    }
}
