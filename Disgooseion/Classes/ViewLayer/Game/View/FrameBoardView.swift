//
//  Created by Codelobber on 17/02/2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

import UIKit

final class FrameBoardView: UIView {
    weak var delegate: BoardViewOutput?
    
    private var selectedCard: CardView?
    private var currentCard: CardView?
    private var deck: CardView = {
        let model = CardViewModel(
            title:"",
            side: .back
        )
        return CardView(model: model)
    }()
    
    private var cardSize: CGSize {
        let widthModificator: CGFloat = 0.8
        let ratio: CGFloat = 1
        
        let width = frame.size.width * widthModificator
        let height = width * ratio
        
        return CGSize(width: width, height: height)
    }
    
    private var cardCenter: CGPoint {
        return CGPoint(x: center.x, y: 75 + cardSize.height/2)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    private func setupSubviews() {
        backgroundColor = .gray
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
        setupDeckLayout()
    }
    
    private func setupCardSize(_ card: CardView) {
        card.frame.size = cardSize
    }
    
    private func setupDeckLayout() {
        let size = cardSize
        let visibleHeight = size.height * 0.6
        
        setupCardSize(deck)
        deck.center.x = center.x
        deck.frame.origin.y = frame.maxY - visibleHeight
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
        
        let card = CardView(model: question.cardViewModel())
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

        let finalPoint = cardCenter
        
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
        
        let card = CardView(model: question.cardViewModel())
        
        self.addSubview(card)
        currentCard = card
        setupCardSize(card)
        card.center = cardCenter
    }
    
    private func removeCurrentCard() {
        currentCard?.removeFromSuperview()
    }
}
