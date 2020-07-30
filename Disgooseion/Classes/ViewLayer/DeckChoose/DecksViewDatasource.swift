//
//  DecksViewDatasource.swift
//  Disgooseion
//
//  Created by allBeFine on 07.07.2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

import UIKit

protocol DecksViewDatasource: UICollectionViewDataSource  {
    func deckForIndex(_ index: IndexPath) -> DeckModel?
}

final class DecksViewDatasourceImpl: NSObject {
    private let reuseIdentifier = "DeckCell"
    private let datasource: QuestionsDatasource
    private let screenConstatants: ScreenConstantsConfiguration
    
    init(
        datasource: QuestionsDatasource,
        screenConstatants: ScreenConstantsConfiguration
    ) {
        self.datasource = datasource
        self.screenConstatants = screenConstatants
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
            cell.screenConstatants = screenConstatants
            cell.model = simpleCardViewModel(for: decks[indexPath.row])
        }
        return cell
    }
    
    private func simpleCardViewModel(for deck: DeckModel) -> SimpleCardViewModel {
        return SimpleCardViewModel(
            text: deck.text.getCurrentLocal() ?? "",
            descript: deck.descript?.getCurrentLocal() ?? "",
            style: CardStyleFace(),
            layoutStyle: screenConstatants.cardStyle.style()
        )
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
                if view == nil {
                    createView(with: model)
                } else {
                    updateView(with: model)
                }
            }
            
        }
    }
    var screenConstatants: ScreenConstantsConfiguration?
    private var view: SimpleCardView?
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = screenConstatants?.textFont
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    init(
        frame: CGRect,
        model: SimpleCardViewModel?,
        screenConstatants: ScreenConstantsConfiguration?
    ) {
        self.model = model
        self.screenConstatants = screenConstatants
        
        super.init(frame: frame)
        
        if let model = model {
            self.createView(with: model)
        }
    }
    
    override convenience init(frame: CGRect) {
        self.init(
            frame: frame,
            model: nil,
            screenConstatants: nil
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateView(with model: SimpleCardViewModel) {
        view?.model = model
        descriptionLabel.font = screenConstatants?.textFont
        descriptionLabel.text = model.descript
    }
    
    private func createView(with model:SimpleCardViewModel) {
        view = SimpleCardView(model: model)
        updateView(with: model)
        setupSubviews()
        setupLayout()
    }
    
    private func setupSubviews() {
        view.map{ contentView.addSubview($0) }
        contentView.addSubview(descriptionLabel)
    }
    
    private func setupLayout() {
        setupViewLayout()
        setupDescriptionLayout()
    }
    
    private func setupViewLayout() {
        guard let view = view else { return }
        view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            view.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            view.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.heightAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }

    private func setupDescriptionLayout() {
        guard let view = view else { return }
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            descriptionLabel.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 20),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
        ])
    }
}
