//
//  DeckModel.swift
//  Disgooseion
//
//  Created by allBeFine on 07.07.2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

struct DeckModel {
    let id: String
    let text: LocalizebleString
    let descript: LocalizebleString?
}

extension DeckModel {
    
    func cardViewModel() -> CardViewModel {
        return CardViewModel(
            faceTitle: "",
            backTitle: text.getCurrentLocal() ?? "",
            side: .back
        )
    }
}
