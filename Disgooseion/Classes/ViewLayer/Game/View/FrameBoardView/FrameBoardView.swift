//
//  Created by Codelobber on 17/02/2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

import UIKit
import Foundation

final class FrameBoardView: UIView {
    weak var delegate: BoardViewOutput?
    
    private var selectedCard: CardView?
    private var currentCard: CardView?
    private var deck: CardView
    private var backgroundView: UIImageView = {
        guard
            let image = UIImage(named: "bg", in: Bundle.main, with: nil)
        else {
            fatalError("Cant load resurce bg")
        }
        let tiledImage =  image.resizableImage(withCapInsets: .zero , resizingMode: .tile)
        let view = UIImageView(image: tiledImage)
        
        return view
    }()
    
    var layoutBuider: FrameBoardLayoutBuilder
    private var layout: FrameBoardLayouts
    private var ViewAddedToSuperView = false
    
    init(frame: CGRect, layoutBuider: FrameBoardLayoutBuilder) {
        let model = CardViewModel(
            title:"",
            side: .back
        )
        
        self.layoutBuider = layoutBuider
        layout = layoutBuider.make(frame: frame)
        deck = CardView(model: model, styleType: layout.cardStyle)
        
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if (!ViewAddedToSuperView) {
            ViewAddedToSuperView = true
            layout = layoutBuider.make(frame: frame)
            setupLayout()
        }
    }
    
    private func setupSubviews() {
        addSubview(backgroundView)
        addSubview(deck)
        
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(deckTap)
        )
        
        let panGesture = UIPanGestureRecognizer(
            target: self,
            action: #selector(handlePan)
        )
        
        deck.addGestureRecognizer(tapGesture)
        deck.addGestureRecognizer(panGesture)
    }
    
    private func setupLayout() {
        setupBackgroundViewLayout()
        setupDeckLayout()
    }
    
    private func setupCardSize(_ card: CardView) {
        card.frame.size = layout.cardSize
    }
    
    private func setupBackgroundViewLayout() {
        backgroundView.stickToParentLayout(with: .zero)
    }
    
    private func setupDeckLayout() {
        setupCardSize(deck)
        deck.center = layout.deckCenter
    }
}

extension FrameBoardView {
    
    @objc
    func deckTap() {
        delegate?.nextQuestion()
    }
    
    func addNewCardIfNeeded(to newCenter: CGPoint) {
        if selectedCard != nil { return }
            
        guard let question = delegate?.getNextQuestion() else {
            return
        }
        
        let card = CardView(model: question.cardViewModel(), styleType: layout.cardStyle)
        card.flip()
        setupCardSize(card)
        card.center = newCenter
        self.addSubview(card)
        selectedCard = card
    }
    
    @objc
    func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let gestureView = gesture.view else {
            return
        }
        addNewCardIfNeeded(to: gestureView.center)
        
        guard let card = selectedCard else {
            return
        }
        
        let translation = gesture.translation(in: self)
        
        card.center = CGPoint(
            x: card.center.x + translation.x,
            y: card.center.y + translation.y
        )
        
        gesture.setTranslation(.zero, in: self)
        
        guard gesture.state == .ended else {
            return
        }
        
        let velocity = gesture.velocity(in: self)
        let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
        let slideMultiplier: CGFloat = 1000/magnitude
        let animationDuration = Double(max(min(0.2 * slideMultiplier, 2), 0.2))

        let finalPoint = layout.cardCenter
        
        UIView.animate(
            withDuration: animationDuration,
            delay: 0,
            // 6
            options: .curveEaseOut,
            animations: {
                card.center = finalPoint
        }) { finished in
            if !finished { return }
            card.flip()
            self.removeCurrentCard()
            self.currentCard = card
        }

        selectedCard = nil
    }
    
    @objc
    func handleCardPan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        
        guard let gestureView = gesture.view else {
            return
        }
        
        gestureView.center = CGPoint(
            x: gestureView.center.x + translation.x,
            y: gestureView.center.y + translation.y
        )
        
        gesture.setTranslation(.zero, in: self)
    }
}

extension FrameBoardView: BoardView {
    
    func showQuestion(_ question: Question) {
        
        removeCurrentCard()
        
        let card = CardView(model: question.cardViewModel(), styleType: layout.cardStyle)
        
        self.addSubview(card)
        currentCard = card
        setupCardSize(card)
        card.center = layout.cardCenter
    }
    
    private func removeCurrentCard() {
        currentCard?.removeFromSuperview()
    }
}
