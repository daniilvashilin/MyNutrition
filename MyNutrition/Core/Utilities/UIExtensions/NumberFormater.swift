//
//  NumberFormater.swift
//  MyNutrition
//
//  Created by Daniil on 30/12/2024.
//

import Foundation

extension NumberFormatter {
    static var calorieFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal // Использует разделитель тысяч
        formatter.maximumFractionDigits = 0 // Убирает десятичные знаки
        return formatter
    }
}
