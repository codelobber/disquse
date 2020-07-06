//
//  Created by codelobber on 09/02/2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

import UIKit

final class GameViewController: UIViewController {
    let gameView: BoardView
    let datasource: QuestionsDatasource

    init(
        gameView: BoardView,
        datasource: QuestionsDatasource
    ) {
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
            self?.showQuestion()
        }
    }
    
    private func showQuestion() {
        guard let nextQuestion = datasource.nextQuestion() else { return }
        gameView.showQuestion(nextQuestion)
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
        if datasource.questionsCount == 0 { gameView.hideDeck(true) }
    }
    
    func getNextQuestion() -> Question? {
        let question = datasource.nextQuestion()
        if datasource.questionsCount == 0 { gameView.hideDeck(true) }
        return question
    }
}
