//
//  Created by Codelobber on 09/02/2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

import UIKit

struct GameAssembly {
    static func gameViewController() -> UIViewController {
        let gameView = BasicBoardView()
        let datasource = MockQuestionsDatasource()
        
        let gameController = GameViewController(
            gameView: gameView,
            datasource: datasource
        )
        return gameController
    }
}
