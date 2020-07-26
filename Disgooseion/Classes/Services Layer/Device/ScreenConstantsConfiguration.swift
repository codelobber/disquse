//
//  ScreenConstantsConfiguration.swift
//  Disgooseion
//

import UIKit

final class ScreenConstantsConfiguration {
    private(set) var cardSize: CGSize = .zero
    private(set) var cardCenter: CGPoint = .zero
    private(set) var deckCenter: CGPoint = .zero
    private(set) var cardStyle = CardLayoutStyle.StyleType.small
    private(set) var screenSize: ScreenSize = .legacy
}

extension ScreenConstantsConfiguration {
    func recalculate(_ frame:CGRect) {
        screenSize = ScreenSize.make(frame: frame)
        
        switch screenSize {
        case .legacy:
            applyLegacyConfiguration(frame)
        case .fifth:
            applyFifthConfiguration(frame)
        case .sixth:
            applySixthConfiguration(frame)
        case .sixthPlus:
            applySixthPlusConfiguration(frame)
        case .xAndAbove:
            applyMaxConfiguration(frame)
        }
    }
    
    private func applyLegacyConfiguration(_ frame:CGRect) {
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
    
    private func applyFifthConfiguration(_ frame:CGRect) {
        let widthModificator: CGFloat = 0.95
        let ratio: CGFloat = 1
        let topMargin:CGFloat = 50
        
        let width = frame.size.width * widthModificator
        let height = width * ratio
        let visibleHeight = height * 0.4
        
        cardStyle = CardLayoutStyle.StyleType.small
        cardSize = CGSize(width: width, height: height)
        cardCenter = CGPoint(x: frame.midX, y: topMargin + height/2)
        deckCenter = CGPoint(x: frame.midX, y: frame.maxY - visibleHeight + height/2)
        
    }
    
    private func applySixthConfiguration(_ frame:CGRect) {
        let widthModificator: CGFloat = 0.9
        let ratio: CGFloat = 1
        let topMargin:CGFloat = 50
        
        let width = frame.size.width * widthModificator
        let height = width * ratio
        let visibleHeight = height * 0.5
        
        cardSize = CGSize(width: width, height: height)
        cardCenter = CGPoint(x: frame.midX, y: topMargin + height/2)
        deckCenter = CGPoint(x: frame.midX, y: frame.maxY - visibleHeight + height/2)
        cardStyle = CardLayoutStyle.StyleType.big
        
    }
    
    private func applySixthPlusConfiguration(_ frame:CGRect) {
        let widthModificator: CGFloat = 0.8
        let ratio: CGFloat = 1
        let topMargin:CGFloat = 75
        
        let width = frame.size.width * widthModificator
        let height = width * ratio
        let visibleHeight = height * 0.6
        
        cardSize = CGSize(width: width, height: height)
        cardCenter = CGPoint(x: frame.midX, y: topMargin + height/2)
        deckCenter = CGPoint(x: frame.midX, y: frame.maxY - visibleHeight + height/2)
        cardStyle = CardLayoutStyle.StyleType.big
        
    }
    
    private func applyMaxConfiguration(_ frame:CGRect) {
        let widthModificator: CGFloat = 0.9
        let ratio: CGFloat = 1
        let topMargin:CGFloat = frame.height * 0.15
        
        let width = frame.size.width * widthModificator
        let height = width * ratio
        let visibleHeight = height * 0.6
        
        cardSize = CGSize(width: width, height: height)
        cardCenter = CGPoint(x: frame.midX, y: topMargin + height/2)
        deckCenter = CGPoint(x: frame.midX, y: frame.maxY - visibleHeight + height/2)
        cardStyle = CardLayoutStyle.StyleType.big
    }
}

