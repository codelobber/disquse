//
//  Created by Codelobber on 12/02/2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

import UIKit

struct CardViewModel {
    enum Side {
        case face
        case back
    }
    let title: String
    let side: Side
}

class CardView: UIView {
    
    private var style: Style = StyleBig()
    
    private let model: CardViewModel
    private var currentSide: CardViewModel.Side
    
    lazy private var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        return label
    }()
    
    lazy private var background: UIView = {
        let view = UIView()
        return view
    }()
    
    init(
        model: CardViewModel,
        styleType: StyleType
    ) {
        self.model = model
        self.style = styleType.style()
        
        currentSide = model.side
        
        super.init(frame: .zero)
        
        setupSubviews()
        updateSubviews()
        updateStyle()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func flip() {
        currentSide = currentSide == .back ? .face : .back
        updateSubviews()
    }
    
    private func setupSubviews() {
        addSubview(background)
        addSubview(label)
    }
    
    func updateStyle() {
        backgroundColor = style.cardColor
        layer.cornerRadius = style.cornerRadius
        
        setupBackground()
        
        setupLayout()
    }
    
    private func setupBackground() {
        background.removeFromSuperview()
        
        if currentSide == .face {
            let edges = UIEdgeInsets(top: 60, left: 60, bottom: 60, right: 60)
            setBackgroundImage("border", capInsets: edges)
        } else {
            setBackgroundImage("backImage", capInsets: .zero)
//
//            background.backgroundColor = backgroundColor(currentSide)
//            background.layer.cornerRadius = style.cornerRadius/2
        }
        
        addSubview(background)
        sendSubviewToBack(background)
    }
    
    private func setBackgroundImage(_ name: String, capInsets:UIEdgeInsets) {
        guard
            let image = UIImage(named: name, in: Bundle.main, with: nil)
            else {
                fatalError("Cant load resurce \(name)")
        }
        let tiledImage = image.resizableImage(withCapInsets: capInsets , resizingMode: .tile)
        background = UIImageView(image: tiledImage)
    }
    
    private func updateSubviews() {
        label.text = model.title
        label.isHidden = currentSide == .back
        updateStyle()
    }
    
    private func setupLayout() {
        setupLabelLayout()
        setupBackgroundLayout()
    }
    
    private func setupBackgroundLayout() {
        background.translatesAutoresizingMaskIntoConstraints = false
        
        background.stickToParentLayout(with: style.cardInsets)
    }
    
    private func setupLabelLayout() {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, constant: -style.labelMargin)
        ])
    }
}

extension CardView {
    
    enum StyleType {
        case big
        case small
        
        fileprivate func style() -> Style {
            switch self {
            case .big: return StyleBig()
            case .small: return StyleSmall()
            }
        }
    }

    fileprivate class Style {
        var cornerRadius: CGFloat = 10
        var cardInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        var labelMargin:CGFloat = 50
        var cardColor = UIColor.white
        var backgroundFaceColor = UIColor.lightGray
        var backgroundBackColor = UIColor.darkGray
        
        init() { }
    }
    
    private class StyleBig: Style {
        override init() {
            super.init()
            cardInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        }
    }
    
    private class StyleSmall: Style {
        override init() {
            super.init()
            labelMargin = 45
            cardInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
    }
    
    private func backgroundColor(_ side: CardViewModel.Side) -> UIColor {
        switch side {
        case .face: return style.backgroundFaceColor
        case .back: return style.backgroundBackColor
        }
    }
}
