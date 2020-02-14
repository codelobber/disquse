//
//  Created by Codelobber on 09/02/2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

/// Datasource for board
protocol QuestionsDatasource {
    func nextQuestion() -> Question
}

final class MockQuestionsDatasource {
    
}

// MARK - <QuestionsDatasource>

extension MockQuestionsDatasource: QuestionsDatasource {
    func nextQuestion() -> Question {
        return Question(id: 0, deck: 0, text: "\(Int.random(in: 10...100)) ")
    }
}
