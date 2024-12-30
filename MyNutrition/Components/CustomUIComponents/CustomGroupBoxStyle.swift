//
//  CustomGroupBoxStyle.swift
//  MyNutrition
//
//  Created by Daniil on 30/12/2024.
//

import SwiftUI


import SwiftUI


extension GroupBoxStyle where Self == PlainGroupBoxStyle {
    static var plain: PlainGroupBoxStyle {
        PlainGroupBoxStyle()
    }
}

struct PlainGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            configuration.label
                .font(.headline)
            configuration.content
        }
        .padding()
    }
}
