//
//  Created by Codelobber on 16/02/2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

import Foundation

class LocalQuestionLoader: QuestionLoader {
    
    func get(_ complition: QuestionLoader.ComplitionClosure) {
        guard
            let path = Bundle.main.url(forResource:"questions", withExtension: "json"),
            let data = try? Data(contentsOf: path),
            let jsonData = try? JSONDecoder().decode(ResponseDTOModel.self, from: data)
        else {
            return
        }
        complition(jsonData)
    }
}
