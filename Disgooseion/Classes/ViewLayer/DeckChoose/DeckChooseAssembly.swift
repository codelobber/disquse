//
//  DeckChooseAssembly.swift
//  Disgooseion
//
//  Created by allBeFine on 06.07.2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

import UIKit

struct DeckChooseAssembly {
    static func makeViewController() -> UIViewController {
        
        let questionDatasource = LocalQuestionsDatasource()
        questionDatasource.load {}
        
        let decksViewDatasource = DecksViewDatasourceImpl(
            datasource: questionDatasource,
            cardLayout: CardStyleBig()
        )

        let view = DecksView(
            frame: .zero,
            layoutBuider: FrameBoardLayoutBuilderImpl(),
            datasource: decksViewDatasource
        )
        
        let viewController = DeckChooseViewController(
            decksView: view
        )
        
        return viewController
    }
}
