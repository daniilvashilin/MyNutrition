import SwiftUI
import AuthenticationServices

struct ReadyRegisterScreenView: View {
    @ObservedObject var viewModel: BaseAuthViewModel
    @ObservedObject var authService: AuthService
    @State private var emailValidationError: String?
    @EnvironmentObject var appState: AppState
    @Environment(\.horizontalSizeClass) var sizeClass
    @State private var signInError: String? = nil
    var topTextFont: Font
    var underTopTextFormFont: Font
    var showLogo: Bool
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        NavigationStack {
            content
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.backGround.edgesIgnoringSafeArea(.all))
                .ignoresSafeArea(.keyboard, edges: .bottom)
                .navigationDestination(isPresented: $viewModel.isAuthenticated) {
                    WelcomePageView()
                }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        if sizeClass == .compact {
            // iPhone: используем ScrollView
            ScrollView {
                formContent
            }
        } else {
            // iPad: без ScrollView
            formContent
        }
    }
    
    private var formContent: some View {
        VStack(spacing: 15) {
            Spacer(minLength: 10)
            // Logo
            Image(showLogo ? "LogoIcon" : "")
                .renderingMode(.template)
                .resizable()
                .frame(width: screenWidth * 0.1, height: screenWidth * 0.1)
                .foregroundStyle(.text)
            
            Text("Welcome to MyNutrition")
                .font(topTextFont)
                .fontWeight(.medium)
                .foregroundStyle(.text)
            
            Text("Enter your email and password or access your account")
                .font(underTopTextFormFont)
                .foregroundStyle(.subText)
                .padding(.bottom, 10)
            
            CustomTextFiledVIew(width: UIScreen.main.formWidth, height: 40, text: $viewModel.email, viewModel: viewModel)
                .padding(.bottom, 10)
            
            CustomSecurFieldView(width: UIScreen.main.formWidth, height: 40, text: $viewModel.password, viewModel: viewModel)
                .padding(.bottom, 20)
            
            CustomSecurFieldView(width: UIScreen.main.formWidth, height: 40, text: $viewModel.passwordConfirmation, viewModel: viewModel)
                .padding(.bottom, 20)
            
            Button {
                Task {
                    emailValidationError = nil
                    do {
                        try viewModel.validateEmail(viewModel.email)
                        try await viewModel.registerWithEmail()
                    } catch let error as BaseAuthViewModel.UnvalidEmailHandel {
                        emailValidationError = error.unvalidEmailHandelDescription
                    } catch {
                        emailValidationError = "Unexpected error occurred"
                    }
                }
            } label: {
                Text("Register")
            }
            .getCustomButtonStyle(width: UIScreen.main.formWidth, height: 45, textColor: .white, backGroundColor: .black, cornerRadius: 10)
            
            Button {
                appState.showRegisterScreen = false
                viewModel.email = ""
                viewModel.password = ""
                viewModel.passwordConfirmation = ""
            } label: {
                Text("Back to login")
            }
            .getCustomButtonStyle(width: UIScreen.main.formWidth, height: 40, textColor: .text, backGroundColor: .textField, cornerRadius: 10)
            if let error = signInError {
                Text(error)
                    .foregroundColor(.red)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
            }
            
            if let error = emailValidationError {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.top, 5)
            }
            
            Spacer(minLength: 10)
        }
    }
}
