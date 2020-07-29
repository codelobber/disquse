//
//  Created by codelobber on 09/02/2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

import UIKit

final class GameViewController: UIViewController {
    let gameView: BoardView
    let datasource: QuestionsDatasource
    let deck: DeckModel

    init(
        deck: DeckModel,
        gameView: BoardView,
        datasource: QuestionsDatasource
    ) {
        self.deck = deck
        self.gameView = gameView
        self.datasource = datasource
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupSubviews()
        setupLayout()
        
        datasource.load { [weak self] in
            guard let self = self else { return }
            self.datasource.chooseDeck(deck: self.deck)
            self.showQuestion()
        }
    }
    
    private func showQuestion() {
        guard let nextQuestion = datasource.nextQuestion() else { return }
        gameView.showQuestion(nextQuestion)
    }
    
    private func showPrevQuestion() {
        guard let prevQuestion = datasource.prevQuestion() else {
            gameView.hideQuestion()
            return
        }
        gameView.showQuestion(prevQuestion)
        gameView.hideDeck(false)
    }
    
    private func setupSubviews() {
        gameView.delegate = self
        view.backgroundColor = .white
        view.addSubview(gameView)
        gameView.alpha = 0
        
        UIView.animate(withDuration: 1, animations: { [weak self] in
            self?.gameView.alpha = 1
        }, completion: nil)
    }
    
    private func setupLayout() {
        gameView.translatesAutoresizingMaskIntoConstraints = false
        gameView.stickToParentLayout(with: .zero)
    }
}

// MARK: - <BoardViewOutput>

extension GameViewController: BoardViewOutput {
    func nextQuestion() {
        showQuestion()
        if datasource.questionsRemains == 0 { gameView.hideDeck(true) }
    }
    
    func prevQuestion() {
        showPrevQuestion()
    }
    
    func getNextQuestion() -> Question? {
        let question = datasource.nextQuestion()
        if datasource.questionsRemains == 0 { gameView.hideDeck(true) }
        return question
    }
    
    func getPrevQuestion() -> Question? {
        let question = datasource.prevQuestion()
        return question
    }
}
