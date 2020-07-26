//
//  Screens.swift
//  Disgooseion
//

import UIKit

enum ScreenSize {
    // 4 - 35inch
    case legacy
    // 5 SE1 - 4inch
    case fifth
    // 6 - 47inch
    case sixth
    // 6 plus - 55inch
    case sixthPlus
    // X 11 Max - 58inch and above
    case xAndAbove
}

extension ScreenSize {

    static func make(frame: CGRect) -> ScreenSize {
        // 4
        if frame.width <= 320 && frame.height <= 480 {
            return .legacy
        }
        // 5 SE
        if frame.width <= 320 && frame.height <= 568 {
            return .fifth
        }
        // 6
        if frame.width <= 375 && frame.height <= 667 {
            return sixth
        }
        // 6 plus
        if frame.width <= 414 && frame.height <= 736 {
            return sixthPlus
        }
        // X
        if frame.width <= 375 && frame.height <= 812 {
            return .xAndAbove
        }
        // 11 Max
        return .xAndAbove
    }
}
