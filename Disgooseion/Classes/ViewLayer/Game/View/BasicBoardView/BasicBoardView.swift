//
//  Created by Codelobber on 09/02/2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

import UIKit

final class BasicBoardView: UIView {
    weak var delegate: BoardViewOutput?
    
    private var currentCard: CardView?
    private var deck: CardView = {
        let model = CardViewModel(
            title:"",
            side: .back
        )
        return CardView(model: model, styleType: layout.cardStyle)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        backgroundColor = .gray
        addSubview(deck)
        
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(deckTap)
        )
        deck.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func deckTap() {
        delegate?.nextQuestion()
    }
    
    private func setupLayout() {
        setupDeckLayout()
    }
    
    private func setupCardLayout() {
        guard let card = self.currentCard else {
            return
        }
        
        card.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            card.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100),
            card.centerXAnchor.constraint(equalTo: centerXAnchor),
            card.widthAnchor.constraint(equalTo: widthAnchor, constant: -40),
            card.heightAnchor.constraint(equalTo: card.widthAnchor)
        ])
    }
    
    private func setupDeckLayout() {
        deck.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            deck.centerYAnchor.constraint(equalTo: bottomAnchor),
            deck.centerXAnchor.constraint(equalTo: centerXAnchor),
            deck.widthAnchor.constraint(equalTo: widthAnchor, constant: -40),
            deck.heightAnchor.constraint(equalTo: deck.widthAnchor)
        ])
    }
}

extension BasicBoardView: BoardView {
    
    func showQuestion(_ question: Question) {
        
        removeCurrentCard()
        
        let card = CardView(model: question.cardViewModel())
        
        self.addSubview(card)
        currentCard = card
        setupCardLayout()
    }
    
    private func removeCurrentCard() {
        currentCard?.removeFromSuperview()
    }
}
