//
//  ViewController.swift
//  Disgooseion
//
//  Created by allBeFine on 09/02/2020.
//  Copyright © 2020 allBeFine. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let screenConstatants: ScreenConstantsConfiguration = ScreenConstantsConfiguration()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        let viewController = DeckChooseAssembly.makeViewController(screenConstatants: screenConstatants)
        
        navigationController?.pushViewController(viewController, animated: false)
    }
}

