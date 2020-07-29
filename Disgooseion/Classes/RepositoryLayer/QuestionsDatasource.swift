//
//  Created by Codelobber on 09/02/2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

/// Datasource for board
protocol QuestionsDatasource {
    typealias loadedClosure = () -> Void
    
    var questionsRemains: Int { get }
    var questionsAnswered: Int { get }
    var decks: [DeckModel]? { get }
    
    func load(_ complition: loadedClosure?)
    func nextQuestion() -> Question?
    func prevQuestion() -> Question?
    func chooseDeck(deck: DeckModel)
}
