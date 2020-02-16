//
//  Created by Codelobber on 09/02/2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

/// Datasource for board
protocol QuestionsDatasource {
    typealias loadedClosure = () -> Void
    
    func load(_ complition: @escaping loadedClosure)
    func nextQuestion() -> Question?
}

final class MockQuestionsDatasource {
    
}

// MARK - <QuestionsDatasource>

extension MockQuestionsDatasource: QuestionsDatasource {
    
    func load(_ complition: @escaping loadedClosure) {
        complition()
    }
    
    func nextQuestion() -> Question? {
        let random = Int.random(in: 10...100)
        let text = LocalizebleString(ru: "ru \(random)", en: "en \(random)")
        return Question(id: 0, deck: 0, text: text)
    }
}
