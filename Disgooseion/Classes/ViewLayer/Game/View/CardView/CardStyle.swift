//
//  CardStyle.swift
//  Disgooseion
//
//  Created by allBeFine on 03/07/2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

import Foundation
import UIKit

class CardStyle {
    var cardColor = UIColor.white
    var backgroundColor = UIColor.lightGray
    var backgroundImageName = "border"
    var backgroundCapInsets: UIEdgeInsets = .zero
    init() { }
}

class CardStyleFace: CardStyle {
    override init() {
        super.init()
        backgroundColor = UIColor.lightGray
        backgroundImageName = "border"
        backgroundCapInsets = UIEdgeInsets(top: 60, left: 60, bottom: 60, right: 60)
    }
}

class CardStyleBack: CardStyle {
    override init() {
        super.init()
        backgroundColor = UIColor.darkGray
        backgroundImageName = "backImage"
        self.backgroundCapInsets = .zero
    }
}

class CardStyleMessage: CardStyle {
    override init() {
        super.init()
        backgroundColor = UIColor.clear
        backgroundImageName = ""
        backgroundCapInsets = .zero
    }
}
