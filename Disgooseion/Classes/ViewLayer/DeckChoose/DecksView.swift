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
        let tiledImage = image.resizableImage(withCapInsets: .zero , resizingMode: .tile)
        let view = UIImageView(image: tiledImage)
        
        return view
    }()
    
    private var layoutBuider: FrameBoardLayoutBuilder
    private var layout: FrameBoardLayouts
    private var viewAddedToSuperView = false
    private var datasource: DecksViewDatasource
    private lazy var showcaseView : UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 300, height: 300)
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(
            frame: frame,
            collectionViewLayout: layout
        )

        view.allowsSelection = false
        view.backgroundColor = .clear
        view.dataSource = datasource
        
        return view
    }()
    
    init(
        frame: CGRect,
        layoutBuider: FrameBoardLayoutBuilder,
        datasource: DecksViewDatasource
    ) {
        self.layoutBuider = layoutBuider
        self.layout = layoutBuider.make(frame: frame)
        self.datasource = datasource
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
            datasource.cardLayout = layoutBuider.make(frame: frame).cardStyle.style()
            setupLayout()
        }
    }
    
    private func setupSubviews() {
        addSubview(backgroundView)
        addSubview(showcaseView)
    }
    
    private func setupLayout() {
        setupBackgroundViewLayout()
        setupShowcaseViewLayout()
    }
    
    private func setupBackgroundViewLayout() {
        backgroundView.stickToParentLayout(with: .zero)
    }
    
    private func setupShowcaseViewLayout() {
        showcaseView.stickToParentLayout(with: .zero)
    }
}
