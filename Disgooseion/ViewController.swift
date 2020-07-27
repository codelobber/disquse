//
//  ViewController.swift
//  Disgooseion
//
//  Created by allBeFine on 09/02/2020.
//  Copyright © 2020 allBeFine. All rights reserved.
//

import UIKit

protocol Router: AnyObject {
    func newGame(deck: DeckModel)
    func deckChoose()
}

class ViewController: UIViewController {
    let screenConstatants: ScreenConstantsConfiguration = ScreenConstantsConfiguration()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        deckChoose()
    }
}

extension ViewController: Router {
    
    func deckChoose() {
        let viewController = DeckChooseAssembly.makeViewController(
            screenConstatants: screenConstatants,
            router: self
        )
        popViewControllerIfneeded()
        navigationController?.pushViewController(viewController, animated: false)
    }
    
    func newGame(deck: DeckModel) {
        let viewController = GameAssembly.makeViewController(
            deck: deck,
            screenConstatants: screenConstatants,
            router: self
        )
        popViewControllerIfneeded()
        navigationController?.pushViewController(viewController, animated: false)
    }
    
    private func popViewControllerIfneeded() {
        navigationController?.popToViewController(self, animated: false)
    }
}

