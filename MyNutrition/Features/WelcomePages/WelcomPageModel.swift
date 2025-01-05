//
//  WelcomPageModel.swift
//  MyNutrition
//
//  Created by Daniil on 05/01/2025.
//

import Foundation


enum Page: String, CaseIterable {
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
        case .greetings: return "This app helps you track your nutrition."
            case .about: return "Now its easy to stay on the track daily."
        case .analytics: return "Provides you with detailed insights."
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
        if index < Page.allCases.count {
            return Page.allCases[index]
        }
        return self // Stay on the last page if out of bounds
    }
    
    var previousPage: Page {
        let index = Int(index) - 1
        if index >= 0 {
            return Page.allCases[index]
        }
        return self
    }
}
