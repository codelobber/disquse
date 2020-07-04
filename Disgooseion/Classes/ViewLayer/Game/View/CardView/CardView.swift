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
    
    private var style: CardLayoutStyle {
        didSet {
            faceView.model.layoutStyle = style
            backView.model.layoutStyle = style
        }
    }
    
    private let model: CardViewModel
    private var currentSide: CardViewModel.Side
    
    private let faceView: SimpleCardView
    private let backView: SimpleCardView
        
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
    
    func setStyleType(_ styleType: StyleType) {
        self.style = styleType.style()
    }
    
    func flip(duration: TimeInterval) {
        currentSide = currentSide == .back ? .face : .back
        guard duration > 0 else {
            updateSubviews()
            return
        }
    
        let fromView = currentSide == .back ? faceView : backView
        let toView = currentSide == .back ? backView : faceView
        
        UIView.transition(
            from: fromView,
            to: toView,
            duration: duration,
            options: [
                .transitionFlipFromTop,
                .showHideTransitionViews,
                .curveEaseOut
            ],
            completion: nil
        )
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
    private func flip(from fromView: UIView,to toView: UIView) {
        fromView.isHidden = false
        toView.isHidden = false
        UIView.transition(
            from: fromView,
            to: toView,
            duration: 1,
            options: [.transitionFlipFromTop, .showHideTransitionViews]
        ){ finished in
            self.setupLayout()
        }
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

