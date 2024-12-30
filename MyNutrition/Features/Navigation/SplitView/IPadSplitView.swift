import SwiftUI


struct IPadSplitView: View {
    @State var selectedTab: NavigationTabModel.TableViewSection = .home
    let viewModel: BaseAuthViewModel
    let authService: AuthService
    let nutritionService: NutritionService
    var body: some View {
        NavigationSplitView {
            List(NavigationTabModel.TableViewSection.allCases, id: \.self) { tab in
                Button {
                    selectedTab = tab
                } label: {
                    HStack {
                        Image(systemName: tab.image ?? "questionmark")
                            .font(.largeTitle)
                        Text(tab.title ?? "No Title")
                            .font(.title3)
                    }
                    .padding()
                    .background(selectedTab == tab ? Color.green.opacity(0.3) : Color.clear)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .scaleEffect(selectedTab == tab ? 1.1 : 1)
                    .animation(.spring(), value: selectedTab == tab) // Анимация
                }
            }
        } detail: {
            navigationTabs(for: selectedTab)
        }
    }
    
    @ViewBuilder
    private func navigationTabs(for option: NavigationTabModel.TableViewSection) -> some View {
        switch option {
        case .home:
            TestHomePageView(
                viewModel: viewModel,
                authservice: authService
            )
            .environmentObject(nutritionService)
        case .charts:
            ChartsTabView()
        case .recepices:
            RecipesTabView()
        }
    }
}

struct ChartsTabView: View {
    var body: some View {
        Text("Charts Tab")
            .frame(width: 400, height: 400)
    }
}

struct RecipesTabView: View {
    var body: some View {
        Text("Recipes Tab")
            .frame(width: 400, height: 400)
    }
}
