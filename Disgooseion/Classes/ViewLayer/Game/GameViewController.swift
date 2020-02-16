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
        view.addSubview(gameView)
    }
    
    private func setupLayout() {
        
        gameView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gameView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gameView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameView.topAnchor.constraint(equalTo: view.topAnchor),
            gameView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - <BoardViewOutput>

extension GameViewController: BoardViewOutput {
    func nextQuestion() {
        showQuestion()
    }
}
