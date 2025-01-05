//
//  WelcomPageModel.swift
//  MyNutrition
//
//  Created by Daniil on 05/01/2025.
//

import Foundation


enum Page: CaseIterable {
    case greetings
    case about
    case analytics
    
    var image: String {
        switch self {
        case .greetings: return "hand.wave.fill"
        case .about: return "info.bubble.fill"
        case .analytics: return "chart.pie.fill"
        }
    }
    var title: String  {
        switch self {
        case .greetings: return "Welcome!"
        case .about: return "Proper Nutrition"
        case .analytics: return "Analyze Yourself"
        }
    }
    
    var description: String {
        switch self {
        case .greetings: return "Hello! Welcome to MyNutrition. This app helps you track your nutrition and analyze your progress."
        case .about: return "MyNutrition is easy to use app that helps you track your nutrition and analyze your progress."
        case .analytics: return "MyNutrition provides you with detailed insights into your nutrition habits."
        }
    }
    
    var index: CGFloat {
        switch self {
        case .greetings: return 0
        case .about: return 1
        case .analytics: return 2
        }
    }
    
    var nextPage: Page {
        let index = Int(index) + 1
        if index < 3 {
            return Page.allCases[index]
        }
        return self
    }
    
    var previousPage: Page {
        let index = Int(index) - 1
        if index >= 0 {
            return Page.allCases[index]
        }
        return self
    }
}
