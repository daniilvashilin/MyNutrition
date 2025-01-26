//
//  ProductViewModel.swift
//  MyNutrition
//
//  Created by Daniil on 22/01/2025.
//


import Foundation
import SwiftUI

final class ProductViewModel: ObservableObject {
    @Published var product: Product? // Хранит информацию о продукте
    @Published var errorMessage: String? // Хранит сообщение об ошибке (если есть)
    @Published var isLoading: Bool = false // Для индикации загрузки
    
    func fetchProduct(byBarcode barcode: String) {
        isLoading = true
        errorMessage = nil
        
        OpenFoodFactsService.shared.fetchProduct(byBarcode: barcode) { [weak self] result in
            DispatchQueue.main.async { // Обновляем UI на главном потоке
                self?.isLoading = false
                switch result {
                case .success(let product):
                    self?.product = product
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}