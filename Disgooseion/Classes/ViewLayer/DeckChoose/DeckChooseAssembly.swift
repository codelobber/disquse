//
//  DeckChooseAssembly.swift
//  Disgooseion
//
//  Created by allBeFine on 06.07.2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

import UIKit

struct DeckChooseAssembly {
    static func makeViewController(
        screenConstatants: ScreenConstantsConfiguration,
        router: Router
    ) -> UIViewController {
        
        let questionDatasource = LocalQuestionsDatasource()
        questionDatasource.load {}
        
        let decksViewDatasource = DecksViewDatasourceImpl(
            datasource: questionDatasource,
            screenConstatants: screenConstatants
        )

        let view = DecksView(
            frame: .zero,
            screenConstatants: screenConstatants,
            datasource: decksViewDatasource
        )
        
        let viewController = DeckChooseViewController(
            decksView: view,
            router: router
        )
        
        return viewController
    }
}
