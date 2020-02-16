//
//  Created by Codelobber on 16/02/2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

final class LocalQuestionsDatasource {
    var questions: [Question]?
    lazy var loader: QuestionLoader = LocalQuestionLoader()
}

// MARK - <QuestionsDatasource>

extension LocalQuestionsDatasource: QuestionsDatasource {
    func load(_ complition: @escaping QuestionsDatasource.loadedClosure) {
        loader.get() { modelDTO in
            questions = modelDTO.questions
                .map{ Question(id: 0, deck: 0, text: $0.title) }
                .shuffled()
            complition()
        }
    }
    
    func nextQuestion() -> Question? {
        return questions?.popLast()
    }
}
