//
//  Created by codelobber on 09/02/2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

import UIKit

protocol BoardView: UIView {
    var delegate: BoardViewOutput? { get set }
    
    func showQuestion(_ question: Question)
    func hideQuestion()
    func hideDeck(_ shouldHide: Bool)
}

protocol BoardViewOutput: AnyObject {
    func nextQuestion()
    func prevQuestion()
    func getNextQuestion() -> Question?
    func getPrevQuestion() -> Question?
    func openMenu()
}
