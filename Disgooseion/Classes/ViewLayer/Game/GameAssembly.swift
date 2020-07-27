//
//  Created by Codelobber on 09/02/2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

import UIKit

struct GameAssembly {
    static func makeViewController(
        screenConstatants: ScreenConstantsConfiguration,
        router: Router
    ) -> UIViewController {

        let gameView = FrameBoardView(
            frame: .zero,
            screenConstatants: screenConstatants
        )
        let datasource = LocalQuestionsDatasource()
        
        let gameController = GameViewController(
            gameView: gameView,
            datasource: datasource
        )
        return gameController
    }
}
