//
//  Created by Codelobber on 16/02/2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

final class LocalQuestionsDatasource {
    var allQuestions: [Question]?
    var currentQuestionsDeck: [Question]?
    var usedQuestionsStack: [Question]?
    var decks: [DeckModel]?
    var questionsIds: [Int]?
    lazy var loader: QuestionLoader = LocalQuestionLoader()
}

// MARK - <QuestionsDatasource>

extension LocalQuestionsDatasource: QuestionsDatasource {

    var questionsCount: Int {
        get {
            return currentQuestionsDeck?.count ?? 0
        }
    }
    
    func load(_ complition: QuestionsDatasource.loadedClosure?) {
        loader.get() { modelDTO in
            allQuestions = modelDTO.questions
                .map{ Question(id: 0, deck: $0.groups, text: $0.title) }
                .shuffled()
            decks = modelDTO.decks
                .map{ DeckModel(id: $0.id, text: $0.title) }
            complition?()
        }
    }
    
    func chooseDeck(deck: DeckModel) {
        currentQuestionsDeck = allQuestions?.filter { $0.deck.contains(deck.id) }
    }
    
    func nextQuestion() -> Question? {
        guard let question = currentQuestionsDeck?.popLast() else {
            return nil
        }
        usedQuestionsStack?.append(question)
        return question
    }
}
