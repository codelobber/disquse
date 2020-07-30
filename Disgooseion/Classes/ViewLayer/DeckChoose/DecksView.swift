//
//  DecksView.swift
//  Disgooseion
//
//  Created by allBeFine on 06.07.2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

import UIKit

protocol DecksViewOutput: AnyObject {
    func didDeckSelected(_ deck:DeckModel)
}

final class DecksView: UIView {
    weak var delegate: DecksViewOutput?
    
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
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Выберите тему для игры"
        label.textAlignment = .center
        label.font = screenConstatants.titleFont
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private let screenConstatants: ScreenConstantsConfiguration

    private var viewAddedToSuperView = false
    private var datasource: DecksViewDatasource
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        var layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: 1, height: 1)
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private lazy var showcaseView : UICollectionView = {
        let view = UICollectionView(
            frame: frame,
            collectionViewLayout: flowLayout
        )

        view.allowsSelection = true
        view.backgroundColor = .clear
        view.dataSource = datasource
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        
        return view
    }()
    
    init(
        frame: CGRect,
        screenConstatants: ScreenConstantsConfiguration,
        datasource: DecksViewDatasource
    ) {
        self.screenConstatants = screenConstatants
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
            screenConstatants.recalculate(frame)
            viewAddedToSuperView = true
            setupLayout()
        }
    }
    
    private func setupSubviews() {
        addSubview(backgroundView)
        addSubview(title)
        addSubview(showcaseView)
    }
    
    private func setupLayout() {
        setupCollectionSizes()
        setupBackgroundViewLayout()
        setupShowcaseViewLayout()
        setupTitleLayout()
    }
    
    private func setupCollectionSizes() {
        flowLayout.itemSize = CGSize(
            width: screenConstatants.cardSize.width,
            height: frame.height*3/4
        )
    }
    
    private func setupBackgroundViewLayout() {
        backgroundView.stickToParentLayout(with: .zero)
    }
    
    private func setupShowcaseViewLayout() {
        showcaseView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            showcaseView.leftAnchor.constraint(equalTo: leftAnchor),
            showcaseView.rightAnchor.constraint(equalTo: rightAnchor),
            showcaseView.bottomAnchor.constraint(
                equalTo: bottomAnchor),
            showcaseView.heightAnchor.constraint(
                equalTo: self.heightAnchor, multiplier: 3/4)
        ])
    }
    
    private func setupTitleLayout() {
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.leftAnchor.constraint(equalTo: leftAnchor, constant: 50),
            title.rightAnchor.constraint(equalTo: rightAnchor, constant: -50),
            title.bottomAnchor.constraint(equalTo: showcaseView.topAnchor),
            title.topAnchor.constraint(equalTo: topAnchor),
        ])
    }
    
}

extension DecksView: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let deck = self.datasource.deckForIndex(indexPath) else {
            return
        }
        
        delegate?.didDeckSelected(deck)
    }
}
