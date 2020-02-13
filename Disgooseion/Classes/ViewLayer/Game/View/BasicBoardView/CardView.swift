//
//  Created by Codelobber on 12/02/2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

import UIKit

struct CardViewModel {
    enum Side {
        case face
        case back
    }
    let title: String
    let side: Side
}

class CardView: UIView {
    
    private let model: CardViewModel
    
    lazy private var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        return label
    }()
    
    lazy private var background: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.backgroundColor(model.side)
        view.layer.cornerRadius = Constants.cornerRadius/2
        
        return view
    }()
    
    init(model: CardViewModel) {
        self.model = model
        super.init(frame: .zero)
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        backgroundColor = Constants.cardColor
        addSubview(background)
        addSubview(label)
        
        label.text = model.title
        self.layer.cornerRadius = Constants.cornerRadius
    }
    
    private func setupLayout() {
        setupLabelLayout()
        setupBackgroundLayout()
    }
    
    private func setupBackgroundLayout() {
        background.translatesAutoresizingMaskIntoConstraints = false
        
        background.stickToParentLayout(with: Constants.cardInsets)
    }
    
    private func setupLabelLayout() {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, constant: -40)
        ])
    }
}

extension CardView {
    private struct Constants {
        static let cornerRadius: CGFloat = 10
        static let cardInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        static let backgroundColor = UIColor.lightGray
        static let cardColor = UIColor.white
        
        static func backgroundColor(_ side: CardViewModel.Side) -> UIColor {
            switch side {
            case .face:
                return UIColor.lightGray
            case .back:
                return UIColor.darkGray
            }
            
        }
    }
}
