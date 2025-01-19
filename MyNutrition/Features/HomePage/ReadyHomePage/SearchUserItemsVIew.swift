//
//  SearchUserItemsVIew.swift
//  MyNutrition
//
//  Created by Daniil on 19/01/2025.
//

import SwiftUI

struct SearchUserItemsVIew: View {
    @Binding var selectItemToAddPage: AddPageSelection
    var width: CGFloat
    var height: CGFloat
    @State private var searchText: String = ""
    @State private var items: [String] = [
          "Apple", "Banana", "Cherry", "Date", "Fig", "Grape", "Kiwi"
      ]
    var filteredItems: [String] {
            if searchText.isEmpty {
                return items // Если текст пуст, показываем все элементы
            } else {
                return items.filter { $0.localizedCaseInsensitiveContains(searchText) }
            }
        }
    var body: some View {
        VStack {
            HStack {
                Text("Search products")
                    .foregroundStyle(.text)
                    .font(.title)
                Spacer()
                Button {
                    selectItemToAddPage = .home
                } label: {
                    Text("Back")
                }
            }
            .padding()
            Spacer()
            TextField("Search...", text: $searchText)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
            
            // Список результатов
            List(filteredItems, id: \.self) { item in
                HStack {
                    Image(systemName: "v.circle.fill")
                        .font(.headline)
                        .foregroundStyle(.green)
                    VStack(alignment: .leading) {
                        Text(item)
                            .font(.headline)
                            .foregroundStyle(.text)
                        HStack {
                            Text("20 cal, 50g")
                                .foregroundStyle(.subText)
                                .font(.footnote)
                        }
                    }
                    Spacer()
                    Button {
                        // Add
                    } label: {
                        Text("+")
                            .foregroundStyle(.text)
                            .font(.footnote)
                    }

                }
                .padding(.horizontal)
            }
            .listStyle(.plain)
            Spacer()
        }
        .frame(width: width, height: height)
    }
}
