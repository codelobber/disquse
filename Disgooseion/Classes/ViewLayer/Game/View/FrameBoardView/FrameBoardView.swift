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
    
    private var viewAddedToSuperView = false
    private var screenConstatants: ScreenConstantsConfiguration
    
    init(
        frame: CGRect,
        screenConstatants: ScreenConstantsConfiguration
    ) {
        let model = CardViewModel(
            faceTitle: "",
            backTitle: "",
            side: .back
        )
        
        self.screenConstatants = screenConstatants
        deck = CardView(model: model, styleType: screenConstatants.cardStyle)
        
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if (!viewAddedToSuperView) {
            viewAddedToSuperView = true
            screenConstatants.recalculate(frame)
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
        card.frame.size = screenConstatants.cardSize
    }
    
    private func setupBackgroundViewLayout() {
        backgroundView.stickToParentLayout(with: .zero)
    }
    
    private func setupDeckLayout() {
        setupCardSize(deck)
        deck.center = screenConstatants.deckCenter
        deck.setStyleType(screenConstatants.cardStyle)
    }
}

// MARK: - nextCard
extension FrameBoardView {
    
    @objc
    func deckTap() {
        delegate?.nextQuestion()
    }
    
    func createNewCardIfNeeded(_ question: Question) -> CardView {
        let card = CardView(
            model: question.cardViewModel(),
            styleType: screenConstatants.cardStyle
        )
        
        setupCardSize(card)
        self.addSubview(card)

        card.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(cardTap)
            )
        )
        return card
    }
    
    func addNewCardIfNeeded(to newCenter: CGPoint) {
        if selectedCard != nil { return }
        guard let question = delegate?.getNextQuestion() else { return }
        selectedCard = createNewCardIfNeeded(question)
        selectedCard?.flip(duration: 0)
        selectedCard?.center = newCenter
    }
    
    @objc
    func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let gestureView = gesture.view else { return }
        
        addNewCardIfNeeded(to: gestureView.center)
        
        guard let card = selectedCard else { return }
        
        let translation = gesture.translation(in: self)
        let finalPoint = screenConstatants.cardCenter
        card.center = CGPoint(
            x: card.center.x + translation.x,
            y: card.center.y + translation.y
        )
        gesture.setTranslation(.zero, in: self)
        guard gesture.state == .ended else { return }
        
        let velocity = gesture.velocity(in: self)
        var scalarVelocity = Double(sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y)))
        scalarVelocity = max(scalarVelocity, 500)
        var animationDuration = len(card.center, finalPoint) / scalarVelocity
        animationDuration = max(animationDuration, 0.25)
        
        UIView.animate(
            withDuration: animationDuration,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                card.center = finalPoint
        }) { finished in
            if !finished { return }
            self.removeCurrentCard()
            self.currentCard = card
        }
        card.flip(duration: animationDuration)
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
    
    private func len(_ startPoint:CGPoint, _ endPoint:CGPoint) -> Double {
        let xlen = endPoint.x - startPoint.x
        let ylen = endPoint.y - startPoint.y
        return Double(sqrt(xlen*xlen + ylen*ylen))
    }
}

// MARK: - prevCard
extension FrameBoardView {
    @objc
    func cardTap() {
        delegate?.prevQuestion()
    }
}

extension FrameBoardView: BoardView {
    
    func showQuestion(_ question: Question) {
        removeCurrentCard()
        currentCard = createNewCardIfNeeded(question)
        currentCard?.center = screenConstatants.cardCenter
    }
    
    func hideQuestion() {
        removeCurrentCard()
    }
    
    func hideDeck(_ shouldHide: Bool) {
        deck.isHidden = shouldHide
    }
    
    private func removeCurrentCard() {
        currentCard?.removeFromSuperview()
        currentCard = nil
    }
}
