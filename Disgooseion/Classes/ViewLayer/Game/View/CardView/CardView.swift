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
    let faceTitle: String
    let backTitle: String
    let side: Side
}

class CardView: UIView {
    
    private var style: CardLayoutStyle
    
    private let model: CardViewModel
    private var currentSide: CardViewModel.Side
    
    private let faceView: UIView
    private let backView: UIView
        
    init(
        model: CardViewModel,
        styleType: StyleType
    ) {
        self.model = model
        self.style = styleType.style()
        
        let faceModel = SimpleCardViewModel(
            text: model.faceTitle,
            style: CardStyleFace(),
            layoutStyle: style
        )
        faceView = SimpleCardView(model: faceModel)
        
        let backModel = SimpleCardViewModel(
            text: model.backTitle,
            style: CardStyleBack(),
            layoutStyle: style
        )
        backView = SimpleCardView(model: backModel)
        
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
        addSubview(faceView)
        addSubview(backView)
    }
    
    func updateStyle() {
        layer.cornerRadius = style.cornerRadius
        setupLayout()
    }
    
    private func updateSubviews() {
        faceView.isHidden = currentSide == .back
        backView.isHidden = !faceView.isHidden
        updateStyle()
    }
    
    private func setupLayout() {
        faceView.translatesAutoresizingMaskIntoConstraints = false
        backView.translatesAutoresizingMaskIntoConstraints = false
        
        faceView.stickToParentLayout(with: .zero)
        backView.stickToParentLayout(with: .zero)
    }
}

extension CardView {
    enum StyleType {
        case big
        case small
        
        fileprivate func style() -> CardLayoutStyle {
            switch self {
            case .big: return CardStyleBig()
            case .small: return CardStyleSmall()
            }
        }
    }
}
