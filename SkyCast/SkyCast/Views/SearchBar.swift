import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var errorMessage: String?
    @FocusState private var isTextFieldFocused: Bool
    let onSubmit: () -> Void
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                TextField(AppStrings.Common.searchLocation.value, text: $searchText)
                    .focused($isTextFieldFocused)
                    .font(.skycast.caption)
                    .foregroundColor(.skycast.black1)
                    .frame(height: DesignConstants.SearchBar.height)
                    .autocorrectionDisabled()
                    .padding(.leading, DesignConstants.padding16)
                    .submitLabel(.search)
                    .onSubmit {
                        guard !searchText.isEmpty else { return }
                        onSubmit()
                        isTextFieldFocused = false
                    }
                Image(systemName: SystemImageConstants.searchIcon)
                    .resizable()
                    .bold()
                    .frame(width: DesignConstants.SearchIcon.width, height: DesignConstants.SearchIcon.width)
                    .padding(.trailing, DesignConstants.padding16)
                    .foregroundColor(.skycast.gray)
            }
            .background(
                RoundedRectangle(cornerRadius: DesignConstants.cornerRadius)
                    .fill(Color.skycast.background)
            )
            .frame(height: DesignConstants.SearchBar.height)
            if let errorMessage = errorMessage, !isTextFieldFocused, !searchText.isEmpty {
                Text(errorMessage)
                    .font(.skycast.caption3)
                    .foregroundColor(Color.skycast.black1)
            }
        }
   }
}


#Preview("SearchBar") {
    SearchBar(
        searchText: .constant(""),
        errorMessage: .constant("test"),
        onSubmit: {}
    )
        .padding(.horizontal, 16)
}


fileprivate struct DesignConstants {
    static let padding16: CGFloat = 16.0
    static let cornerRadius: CGFloat = 16.0
    

    enum SearchIcon {
        static let width: CGFloat = 18.0
        static let height: CGFloat = 18.0
    }
    
    enum SearchBar {
        static let height: CGFloat = 46.0
    }
}
