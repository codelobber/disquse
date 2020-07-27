//
//  MockQuestionsDatasource.swift
//  Disgooseion
//
//  Created by allBeFine on 05.07.2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

final class MockQuestionsDatasource {
    
}

// MARK - <QuestionsDatasource>

extension MockQuestionsDatasource: QuestionsDatasource {
    
    var questionsCount: Int {
        get {
            return 999
        }
    }
    
    var decks: [DeckModel]? {
        get {
            return [
                DeckModel(
                    id: "Simple",
                    text: LocalizebleString(ru: "ru", en: "en")
                )
            ]
        }
    }
    
    func load(_ complition: loadedClosure?) {
        complition?()
    }
    
    func chooseDeck(deck: DeckModel) {}
    
    func nextQuestion() -> Question? {
        let random = Int.random(in: 10...100)
        let text = LocalizebleString(ru: "ru \(random)", en: "en \(random)")
        return Question(id: 0, deck: ["Simple"], text: text)
    }
}
