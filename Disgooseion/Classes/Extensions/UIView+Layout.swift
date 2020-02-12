//
//  Created by Codelobber on 12/02/2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

import UIKit

extension UIView {
    
    func stickToParentLayout(with inset:UIEdgeInsets) {
        guard let superview = self.superview else {
            return
        }
        
        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: superview.leftAnchor, constant:inset.left),
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant:inset.top),
            self.rightAnchor.constraint(equalTo: superview.rightAnchor, constant:-inset.right),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant:-inset.bottom),
        ])
    }
}
