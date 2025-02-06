import SwiftUI
 
extension Font {
    struct skycast {
        static let largeTitle = Font.custom("Poppins-Medium", size: 70, relativeTo: .largeTitle)
        static let largeTitle2 = Font.custom("Poppins-Medium", size: 60, relativeTo: .largeTitle)
        static let title = Font.custom("Poppins-Bold", size: 30, relativeTo: .title)
        static let title2 = Font.custom("Poppins-Bold", size: 20, relativeTo: .title2)
        static let caption = Font.custom("Poppins-Regular", size: 15)
        static let caption2 = Font.custom("Poppins-SemiBold", size: 12, relativeTo: .caption2)
        static let caption3 = Font.custom("Poppins-SemiBold", size: 15,  relativeTo: .footnote)
        static let footnote = Font.custom("Poppins-Regular", size: 8,  relativeTo: .footnote)
    }
}
