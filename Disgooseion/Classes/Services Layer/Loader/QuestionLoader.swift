//
//  Created by Codelobber on 16/02/2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

protocol QuestionLoader {
    typealias ComplitionClosure = (_ model: ResponseDTOModel) -> Void
    
    func get(_ complition: ComplitionClosure)
}

