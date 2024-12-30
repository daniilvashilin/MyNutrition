import SwiftUI

struct CustomTextFiledVIew: View {
    var width: CGFloat
    var height: CGFloat
    var headlineText: String = "Email"
    @Binding var text: String
    @ObservedObject var viewModel: BaseAuthViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(headlineText)
                .fontWeight(.medium)
            TextField("Enter email", text: $text)
                .padding()
                .frame(width: width, height: height)
                .background(Color(.textField))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .foregroundStyle(.text)
        }
    }
}
