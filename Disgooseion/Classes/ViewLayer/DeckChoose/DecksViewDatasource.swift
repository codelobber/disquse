//
//  DecksViewDatasource.swift
//  Disgooseion
//
//  Created by allBeFine on 07.07.2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

import UIKit

protocol DecksViewDatasource: UICollectionViewDataSource  {
    var cardLayout: CardLayoutStyle { get set }
    func deckForIndex(_ index: IndexPath) -> DeckModel?
}

final class DecksViewDatasourceImpl: NSObject {
    private let reuseIdentifier = "DeckCell"
    private let datasource: QuestionsDatasource
    var cardLayout: CardLayoutStyle
    
    init(
        datasource: QuestionsDatasource,
        cardLayout: CardLayoutStyle
    ) {
        self.datasource = datasource
        self.cardLayout = cardLayout
        super.init()
    }
}

extension DecksViewDatasourceImpl: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return datasource.decks?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        collectionView.register(
            DeckCell.self,
            forCellWithReuseIdentifier: reuseIdentifier)
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath)
        if
            let cell = cell as? DeckCell,
            let decks = datasource.decks,
            decks.indices.contains(indexPath.row)
        {
            cell.model = simpleCardViewModel(for: decks[indexPath.row])
        }
        return cell
    }
    
    private func simpleCardViewModel(for deck: DeckModel) -> SimpleCardViewModel {
        return SimpleCardViewModel(
            text: deck.text.getCurrentLocal() ?? "",
            style: CardStyleFace(),
            layoutStyle: cardLayout)
    }
}

extension DecksViewDatasourceImpl: DecksViewDatasource {
    func deckForIndex(_ index: IndexPath) -> DeckModel? {
        guard
            let decks = datasource.decks,
            decks.indices.contains(index.row)
        else { return nil }
        
        return decks[index.row]
    }
}

// MARK: - DeckCell

class DeckCell: UICollectionViewCell {
    var model: SimpleCardViewModel? {
        didSet {
            if let model = model {
                if let view = view {
                    view.model = model
                } else {
                    self.createView(with: model)
                }
            }
            
        }
    }
    private var view: SimpleCardView?
    
    init(
        frame: CGRect,
        model: SimpleCardViewModel?
    ) {
        self.model = model
        
        super.init(frame: frame)
        
        if let model = model {
            self.createView(with: model)
        }
    }
    
    override convenience init(frame: CGRect) {
        self.init(
            frame: frame,
            model: nil
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createView(with model:SimpleCardViewModel) {
        view = SimpleCardView(model: model)
        setupSubviews()
        setupLayout()
    }
    
    private func setupSubviews() {
        view.map{ contentView.addSubview($0) }
    }
    
    private func setupLayout() {
        view?.stickToParentLayout(with: .zero)
        contentView.stickToParentLayout(with: .zero)
    }
}
