//
//  Created by codelobber on 09/02/2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

import UIKit

final class GameViewController: UIViewController {
    let gameView: CardView
    let datasource: QuestionsDatasource

    init(
        gameView: CardView,
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
        
        showQuestion()
    }
    
    private func showQuestion() {
        gameView.showQuestion(datasource.nextQuestion())
    }
    
    private func setupSubviews() {
        view.addSubview(gameView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            gameView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gameView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameView.topAnchor.constraint(equalTo: view.topAnchor),
            gameView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
