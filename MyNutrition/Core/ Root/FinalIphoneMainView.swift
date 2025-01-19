import SwiftUI

struct FinalIphoneMainView: View {
    @State var selectedTabIphone: NavigationTabModel.TableViewSection = .home
    @EnvironmentObject var nutritionService: NutritionService
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject var viewModel: BaseAuthViewModel
    @State var showAddPage = false
    @State var selectItemToAddPage: AddPageSelection = .home

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.backGround
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    ZStack {
                        if selectedTabIphone == .home {
                            switch selectItemToAddPage {
                            case .searchNew:
                                SearchUserItemsVIew(selectItemToAddPage: $selectItemToAddPage, width: geometry.size.width, height: geometry.size.height * 0.85)
                            case .searchUserItems:
                                SearchUserItemsVIew(selectItemToAddPage: $selectItemToAddPage, width: geometry.size.width, height: geometry.size.height * 0.85)
                            case .home:
                                TestHomePageView(viewModel: viewModel, authservice: authService)
                            }
                        } else if selectedTabIphone == .charts {
                            ChartsTabView()
                        } else {
                            RecipesTabView()
                        }
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.85)

                    CustomTabView(selectedTab: $selectedTabIphone, showAddPage: $showAddPage)
                        .frame(height: geometry.size.height * 0.15)
                        .sheet(isPresented: $showAddPage) {
                            AddPageSheetView(selectItemToAddPage: $selectItemToAddPage, showAddPage: $showAddPage)
                                .presentationDetents([.fraction(0.25), .large])
                        }
                }
                .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}
