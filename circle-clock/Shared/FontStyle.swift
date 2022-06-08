//
//  FontStyle.swift
//  circle-clock
//
//  Created by Wei Lun Hsu on 2022/6/7.
//

import Foundation
import SwiftUI

struct TokenFontStyle {
    let mainFont: Font = Font.custom(FontFamily.Radioland.rawValue, size: FontSize.medium.rawValue)
}

extension TokenFontStyle {
    private enum FontSize: CGFloat {
        case medium = 20
    }
    
    private enum FontFamily: String {
        case Radioland = "Radioland"
    }
}

extension Font {
    static let FontStyle = TokenFontStyle()
}
