//
//  Created by Codelobber on 16/02/2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

final class LocalQuestionsDatasource {
    var questions: [Question]?
    var decks: [DeckModel]?
    var questionsIds: [Int]?
    lazy var loader: QuestionLoader = LocalQuestionLoader()
}

// MARK - <QuestionsDatasource>

extension LocalQuestionsDatasource: QuestionsDatasource {

    var questionsCount: Int {
        get {
            return questions?.count ?? 0
        }
    }
    
    func load(_ complition: QuestionsDatasource.loadedClosure?) {
        loader.get() { modelDTO in
            questions = modelDTO.questions
                .map{ Question(id: 0, deck: $0.groups, text: $0.title) }
                .shuffled()
            decks = modelDTO.decks
                .map{ DeckModel(id: $0.id, text: $0.title) }
            complition?()
        }
    }
    
    func nextQuestion() -> Question? {
        return questions?.popLast()
    }
}
