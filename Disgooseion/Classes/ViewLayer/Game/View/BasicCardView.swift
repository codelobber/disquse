//
//  Created by Codelobber on 09/02/2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

import UIKit

final class BasicCardView: UIView {
    private let label: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(label)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

extension BasicCardView: CardView {
    func showQuestion(_ question: Question) {
        label.text = question.text
    }
}
