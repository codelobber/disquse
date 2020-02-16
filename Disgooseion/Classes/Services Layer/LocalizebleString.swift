//
//  LocalizebleString.swift
//  Disgooseion
//
//  Created by allBeFine on 16/02/2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

struct LocalizebleString: Decodable {
    let ru: String?
    let en: String?
    
    func getCurrentLocal() -> String? {
        return ru
    }
}
