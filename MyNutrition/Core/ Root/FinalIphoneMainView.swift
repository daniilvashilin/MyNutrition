import SwiftUI

struct FinalIphoneMainView: View {
    @State var selectedTabIphone: NavigationTabModel.TableViewSection = .home
    @EnvironmentObject var nutritionService: NutritionService
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject var viewModel: BaseAuthViewModel

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) { 
                ZStack {
                    if selectedTabIphone == .home {
                        TestHomePageView(viewModel: viewModel, authservice: authService)
//                            .border(.red)
                    } else if selectedTabIphone == .charts {
                        ChartsTabView()
//                            .border(.red)
                    } else {
                        RecipesTabView()
//                            .border(.red)
                    }
                }
                .frame(width: geometry.size.width ,height: geometry.size.height * 0.85)
                
                CustomTabView(selectedTab: $selectedTabIphone)
                    .frame(height: geometry.size.height * 0.15)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}
