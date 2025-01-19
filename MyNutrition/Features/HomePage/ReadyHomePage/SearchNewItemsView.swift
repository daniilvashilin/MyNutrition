//
//  SearchNewItems.swift
//  MyNutrition
//
//  Created by Daniil on 19/01/2025.
//

import SwiftUI

struct SearchNewItemsView: View {
    @Binding var selectItemToAddPage: AddPageSelection
    var width: CGFloat
    var height: CGFloat
    var body: some View {
        VStack {
            HStack {
                Button {
                    selectItemToAddPage = .home
                } label: {
                    Text("Back")
                }
                Spacer()
            }
            .padding()
            Spacer()
        }
        .frame(width: width, height: height)
    }
}
