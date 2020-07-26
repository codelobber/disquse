//
//  DeckChooseViewController.swift
//  Disgooseion
//
//  Created by allBeFine on 06.07.2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

import UIKit

final class DeckChooseViewController: UIViewController {
    let decksView: DecksView

    init(
        decksView: DecksView
    ) {
        self.decksView = decksView
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupSubviews()
        setupLayout()
    }
        
    private func setupSubviews() {
//        decksView.delegate = self
        view.backgroundColor = .white
        view.addSubview(decksView)
        decksView.alpha = 0
        
        UIView.animate(withDuration: 1, animations: { [weak self] in
            self?.decksView.alpha = 1
        }, completion: nil)
    }
    
    private func setupLayout() {
        decksView.translatesAutoresizingMaskIntoConstraints = false
        decksView.stickToParentLayout(with: .zero)
    }
}
