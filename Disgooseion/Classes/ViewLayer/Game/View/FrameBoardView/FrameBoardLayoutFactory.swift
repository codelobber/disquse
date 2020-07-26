//
//  Created by Codelobber on 18/02/2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

import UIKit

protocol FrameBoardLayoutBuilder {
    func make(frame: CGRect) -> FrameBoardLayouts
}

final class FrameBoardLayoutBuilderImpl: FrameBoardLayoutBuilder {
    func make(frame: CGRect) -> FrameBoardLayouts {
        // 4
        if frame.width <= 320 && frame.height <= 480 {
            return FrameBoardLayouts35inch(frame: frame)
        }
        // 5 SE
        if frame.width <= 320 && frame.height <= 568 {
            return FrameBoardLayouts4inch(frame: frame)
        }
        // 6
        if frame.width <= 375 && frame.height <= 667 {
            return FrameBoardLayouts47inch(frame: frame)
        }
        // 6 plus
        if frame.width <= 414 && frame.height <= 736 {
            return FrameBoardLayouts55inch(frame: frame)
        }
        // X
        if frame.width <= 375 && frame.height <= 812 {
            return FrameBoardLayouts58inch(frame: frame)
        }
        // 11 Max
        return FrameBoardLayouts58inch(frame: frame)

    }
}

// 4
// TODO: need update
struct FrameBoardLayouts35inch: FrameBoardLayouts {
    let cardSize: CGSize
    let cardCenter: CGPoint
    let deckCenter: CGPoint
    let cardStyle = CardLayoutStyle.StyleType.small
    
    
    init(frame: CGRect) {
        let widthModificator: CGFloat = 0.95
        let ratio: CGFloat = 1
        let topMargin:CGFloat = 25
        
        let width = frame.size.width * widthModificator
        let height = width * ratio
        let visibleHeight = height * 0.4

        cardSize = CGSize(width: width, height: height)
        cardCenter = CGPoint(x: frame.midX, y: topMargin + height/2)
        deckCenter = CGPoint(x: frame.midX, y: frame.maxY - visibleHeight + height/2)
    }
}

// SE
struct FrameBoardLayouts4inch: FrameBoardLayouts {
    let cardSize: CGSize
    let cardCenter: CGPoint
    let deckCenter: CGPoint
    let cardStyle = CardLayoutStyle.StyleType.small
    
    init(frame: CGRect) {
        let widthModificator: CGFloat = 0.95
        let ratio: CGFloat = 1
        let topMargin:CGFloat = 50
        
        let width = frame.size.width * widthModificator
        let height = width * ratio
        let visibleHeight = height * 0.4

        cardSize = CGSize(width: width, height: height)
        cardCenter = CGPoint(x: frame.midX, y: topMargin + height/2)
        deckCenter = CGPoint(x: frame.midX, y: frame.maxY - visibleHeight + height/2)
    }
}

// 6
struct FrameBoardLayouts47inch: FrameBoardLayouts {
    let cardSize: CGSize
    let cardCenter: CGPoint
    let deckCenter: CGPoint
    let cardStyle = CardLayoutStyle.StyleType.big
    
    init(frame: CGRect) {
        let widthModificator: CGFloat = 0.9
        let ratio: CGFloat = 1
        let topMargin:CGFloat = 50
        
        let width = frame.size.width * widthModificator
        let height = width * ratio
        let visibleHeight = height * 0.5

        cardSize = CGSize(width: width, height: height)
        cardCenter = CGPoint(x: frame.midX, y: topMargin + height/2)
        deckCenter = CGPoint(x: frame.midX, y: frame.maxY - visibleHeight + height/2)
    }
}

// 6 plus
struct FrameBoardLayouts55inch: FrameBoardLayouts {
    let cardSize: CGSize
    let cardCenter: CGPoint
    let deckCenter: CGPoint
    let cardStyle = CardLayoutStyle.StyleType.big
    
    init(frame: CGRect) {
        let widthModificator: CGFloat = 0.8
        let ratio: CGFloat = 1
        let topMargin:CGFloat = 75
        
        let width = frame.size.width * widthModificator
        let height = width * ratio
        let visibleHeight = height * 0.6

        cardSize = CGSize(width: width, height: height)
        cardCenter = CGPoint(x: frame.midX, y: topMargin + height/2)
        deckCenter = CGPoint(x: frame.midX, y: frame.maxY - visibleHeight + height/2)
    }
}

// X
struct FrameBoardLayouts58inch: FrameBoardLayouts {
    let cardSize: CGSize
    let cardCenter: CGPoint
    let deckCenter: CGPoint
    let cardStyle = CardLayoutStyle.StyleType.big
    
    init(frame: CGRect) {
        let widthModificator: CGFloat = 0.9
        let ratio: CGFloat = 1
        let topMargin:CGFloat = frame.height * 0.15
        
        let width = frame.size.width * widthModificator
        let height = width * ratio
        let visibleHeight = height * 0.6

        cardSize = CGSize(width: width, height: height)
        cardCenter = CGPoint(x: frame.midX, y: topMargin + height/2)
        deckCenter = CGPoint(x: frame.midX, y: frame.maxY - visibleHeight + height/2)
    }
}
