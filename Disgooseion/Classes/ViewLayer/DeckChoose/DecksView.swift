//
//  DecksView.swift
//  Disgooseion
//
//  Created by allBeFine on 06.07.2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

import UIKit

final class DecksView: UIView {
//    weak var delegate: BoardViewOutput?
    
    private var backgroundView: UIImageView = {
        guard
            let image = UIImage(named: "bg", in: Bundle.main, with: nil)
            else {
                fatalError("Cant load resurce bg")
        }
        let tiledImage =  image.resizableImage(withCapInsets: .zero , resizingMode: .tile)
        let view = UIImageView(image: tiledImage)
        
        return view
    }()
    
    private var layoutBuider: FrameBoardLayoutBuilder
    private var layout: FrameBoardLayouts
    private var viewAddedToSuperView = false
    
    init(frame: CGRect, layoutBuider: FrameBoardLayoutBuilder) {
        self.layoutBuider = layoutBuider
        self.layout = layoutBuider.make(frame: frame)
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if (!viewAddedToSuperView) {
            viewAddedToSuperView = true
            layout = layoutBuider.make(frame: frame)
            setupLayout()
        }
    }
    
    private func setupSubviews() {
        addSubview(backgroundView)
    }
    
    private func setupLayout() {
        setupBackgroundViewLayout()
    }
    
    private func setupBackgroundViewLayout() {
        backgroundView.stickToParentLayout(with: .zero)
    }
}
