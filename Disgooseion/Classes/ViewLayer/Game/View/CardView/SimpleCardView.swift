//
//  Created by Codelobber on 05/03/2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

import UIKit

struct SimpleCardViewModel {
    var text: String
    var descript: String?
    var style: CardStyle
    var layoutStyle: CardLayoutStyle
}

final class SimpleCardView: UIView {
    var model: SimpleCardViewModel {
        didSet {
            updateSubviews()
        }
    }
    
    lazy private var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        return label
    }()
    
    lazy private var background = UIView()
    
    init(model: SimpleCardViewModel) {
        self.model = model
        super.init(frame: .zero)
        
        setupSubviews()
        updateStyle()
        updateSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SimpleCardView {
    private func backgroundColor(_ side: CardViewModel.Side) -> UIColor {
        return model.style.backgroundColor
    }
    
    private func setupSubviews() {
        addSubview(background)
        addSubview(label)
    }
    
    func updateStyle() {
        backgroundColor = model.style.cardColor
        layer.cornerRadius = model.layoutStyle.cornerRadius
        
        setupBackground()
        setupLayout()
    }
    
    private func setupBackground() {
        background.removeFromSuperview()
        
        setBackgroundImage(
            model.style.backgroundImageName,
            capInsets: model.style.backgroundCapInsets
        )
        
        addSubview(background)
        sendSubviewToBack(background)
    }
    
    private func setBackgroundImage(_ name: String, capInsets:UIEdgeInsets) {
        guard
            let image = UIImage(named: name, in: Bundle.main, with: nil)
        else {
            fatalError("Cant load resurce \(name)")
        }
        let tiledImage = image.resizableImage(withCapInsets: capInsets , resizingMode: .tile)
        background = UIImageView(image: tiledImage)
    }
    
    private func updateSubviews() {
        label.text = model.text
        label.isHidden = model.text.isEmpty
        updateStyle()
    }
    
    private func setupLayout() {
        setupLabelLayout()
        setupBackgroundLayout()
    }
    
    private func setupBackgroundLayout() {
        background.translatesAutoresizingMaskIntoConstraints = false
        background.stickToParentLayout(with: model.layoutStyle.cardInsets)
    }
    
    private func setupLabelLayout() {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.widthAnchor.constraint(
                lessThanOrEqualTo: widthAnchor,
                constant: -2 * model.layoutStyle.labelMargin
            )
        ])
    }
}
