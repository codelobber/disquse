//
//  CardStyle.swift
//  Disgooseion
//
//  Created by allBeFine on 03/07/2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

import Foundation
import UIKit

class CardLayoutStyle {
    var cornerRadius: CGFloat = 10
    var cardInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    var labelMargin: CGFloat = 50
    init() { }
}

class CardStyleBig: CardLayoutStyle {
    override init() {
        super.init()
        labelMargin = 60
        cardInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
}

class CardStyleSmall: CardLayoutStyle {
    override init() {
        super.init()
        labelMargin = 45
        cardInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
