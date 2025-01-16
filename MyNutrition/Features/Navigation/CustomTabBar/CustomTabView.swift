//
//  CustomTabView.swift
//  MyNutrition
//
//  Created by Daniil on 29/12/2024.
//

import SwiftUI

struct CustomTabView: View {
    @Binding var selectedTab: NavigationTabModel.TableViewSection
    @Binding var addButtonPressed: Bool
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.textField)
            HStack(spacing: 20) {
            ForEach(NavigationTabModel.TableViewSection.allCases, id: \.self) {tab in
                    Button {
                        selectedTab = tab
                    } label: {
                        Image(systemName: tab.image ?? "Image")
                            .foregroundStyle(.text)
                            .font(.title2)
//                            .scaleEffect(selectedTab == tab ? 1.1 : 1)
                    }
                    .padding()
                    .background(selectedTab == tab ? .customGreen : .clear)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .animation(.spring(), value: tab)
                }
                Button {
                    addButtonPressed = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .foregroundStyle(.green.gradient)
                        .font(.title)
                }
            }
        }
        .frame(width: 320, height: 80)
    }
}



