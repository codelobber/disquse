//
//  Created by Codelobber on 09/02/2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

/// Datasourcer for 
protocol QuestionsDatasource {
    func nextQuestion() -> Question
}

final class MockQuestionsDatasource {
    
}

extension MockQuestionsDatasource: QuestionsDatasource {
    func nextQuestion() -> Question {
        return Question(id: 0, deck: 0, text: "Что ты делал в этот день четыре года назад? ")
    }
}
