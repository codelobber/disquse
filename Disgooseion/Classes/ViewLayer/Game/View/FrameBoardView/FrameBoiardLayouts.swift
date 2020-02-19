//
//  Created by Codelobber on 18/02/2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

import UIKit

protocol FrameBoardLayouts {
    var cardSize: CGSize { get }
    var cardCenter: CGPoint { get }
    var deckCenter: CGPoint { get }
    var cardStyle: CardView.StyleType { get }
}
