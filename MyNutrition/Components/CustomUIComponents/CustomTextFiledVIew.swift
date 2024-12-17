//
//  CustomTextFiledVIew.swift
//  MyNutrition
//
//  Created by Daniil on 17/12/2024.
//

import SwiftUI

struct CustomTextFiledVIew: View {
    var width: CGFloat
    var height: CGFloat
    var headlineText: String = "Email"
    @ObservedObject var viewModel: BaseAuthViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(headlineText)
                .fontWeight(.medium)
            TextField("Enter email", text: $viewModel.email)
                .padding()
                .frame(width: width, height: height)
                .background(Color(.textField))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .foregroundStyle(.text)
        }
    }
}
