import SwiftUI

struct NavigationTabModel {
    enum TableViewSection: Int, CaseIterable {
        case home
        case charts
        case recepices
        
        var title: String? {
            switch self {
            case .home: return "Home"
            case .charts: return "Charts"
            case .recepices: return "Recepies"
            }
        }
        
        var image: String? {
            switch self {
            case .home: return "house.fill"
            case .charts: return "chart.pie.fill"
            case .recepices: return "fork.knife.circle.fill"
            }
        }
    }
}
