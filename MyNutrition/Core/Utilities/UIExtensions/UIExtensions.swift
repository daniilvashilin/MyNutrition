//
//  UIExtensions.swift
//  MyNutrition
//
//  Created by Daniil on 17/12/2024.
//

import Foundation
import SwiftUICore
import SwiftUI


// Device is Ipad or no ?? X
extension View {
    var isIpad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
}


extension View {
    func getCustomButtonStyle(width: CGFloat = 450, height: CGFloat = 50, textColor: Color = .text, backGroundColor: Color = .textField, cornerRadius: CGFloat = 15) -> some View {
        self.buttonStyle(CustomButtonStyle(width: width, height: height, textColor: textColor, backGroundColor: backGroundColor, cornerRadius: cornerRadius))
    }
}


