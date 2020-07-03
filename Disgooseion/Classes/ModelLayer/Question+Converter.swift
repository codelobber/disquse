//
//  Question+Converter.swift
//  Disgooseion
//
//  Created by allBeFine on 13/02/2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

extension Question {
    
    func cardViewModel() -> CardViewModel {
        return CardViewModel(
            faceTitle: text.getCurrentLocal() ?? "",
            backTitle: "",
            side: .face
        )
    }
}
