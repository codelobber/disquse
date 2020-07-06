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

        let view = DecksView(
            frame: .zero,
            layoutBuider: FrameBoardLayoutBuilderImpl()
        )
        let datasource = LocalQuestionsDatasource()
        
        let viewController = DeckChooseViewController(
            decksView: view,
            datasource: datasource
        )
        return viewController
    }
}
