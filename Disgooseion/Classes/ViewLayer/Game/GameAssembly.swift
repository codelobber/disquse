//
//  Created by Codelobber on 09/02/2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

import UIKit

struct GameAssembly {
    static func makeViewController(
        deck: DeckModel,
        screenConstatants: ScreenConstantsConfiguration,
        router: Router
    ) -> UIViewController {

        let gameView = FrameBoardView(
            frame: .zero,
            screenConstatants: screenConstatants
        )
        let datasource = LocalQuestionsDatasource()
        
        let gameController = GameViewController(
            deck: deck,
            gameView: gameView,
            datasource: datasource,
            router: router
        )
        return gameController
    }
}
