import SwiftUI
import FirebaseAuth

struct TestHomePageView: View {
    @ObservedObject var viewModel: BaseAuthViewModel
    @ObservedObject var authservice: AuthService
    @EnvironmentObject var nutritionService: NutritionService
    @Environment(\.horizontalSizeClass) var sizeClass
    var body: some View {
        if sizeClass == .compact {
            GeometryReader { geom in
                ScrollView {
                    VStack(alignment: .center) {
                        CaloriesGroupBoxView(height: geom.size.height * 0.45, width: geom.size.width, corner: geom.size.width * 0.05)
                    }
                }
            }
        } else if sizeClass == .regular {
                GeometryReader { geom in
                    CaloriesGroupBoxView(height: geom.size.height * 0.4, width: geom.size.width * 0.6, corner: geom.size.width * 0.05)
            }
        }
    }
}

