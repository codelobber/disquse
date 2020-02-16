//
//  Created by Codelobber on 16/02/2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

struct ResponseDTOModel: Decodable {
    let decks: [DeckDTOModel]
    let questions: [QuestionDTOModel]
}

struct DeckDTOModel: Decodable {
    let id: String
    let title: LocalizebleString
}

struct QuestionDTOModel: Decodable {
    let groups: [String]
    let title: LocalizebleString
}
