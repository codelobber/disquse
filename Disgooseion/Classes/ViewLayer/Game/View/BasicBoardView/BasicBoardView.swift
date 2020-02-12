//
//  Created by Codelobber on 09/02/2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

import UIKit

final class BasicBoardView: UIView {
    private var currentCard: CardView?
    
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
//        addSubview(label)
    }
    
    private func setupLayout() {
    }
    
    private func setupCardLayout() {
        guard let card = self.currentCard else {
            return
        }
        
        card.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            card.centerYAnchor.constraint(equalTo: centerYAnchor),
            card.centerXAnchor.constraint(equalTo: centerXAnchor),
            card.centerYAnchor.constraint(equalTo: centerYAnchor),
            card.widthAnchor.constraint(equalTo: widthAnchor, constant: -40),
            card.heightAnchor.constraint(equalTo: card.widthAnchor)
        ])
    }
}

extension BasicBoardView: BoardView {
    
    func showQuestion(_ question: Question) {
        let card = CardView(question: question)
        
        self.addSubview(card)
        currentCard = card
        setupCardLayout()
    }
}
