//
//  MainMenuViewController.swift
//  Disgooseion
//
//  Created by allBeFine on 06.07.2020.
//  Copyright © 2020 Codelobber. All rights reserved.
//

import UIKit

final class MainMenuViewController: UIViewController {
    let menuView: MainMenuView

    init(
        menuView: MainMenuView
    ) {
        self.menuView = menuView
        
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
        view.backgroundColor = .white
        view.addSubview(menuView)
        menuView.alpha = 0
        
        UIView.animate(withDuration: 1, animations: { [weak self] in
            self?.menuView.alpha = 1
        }, completion: nil)
    }
    
    private func setupLayout() {
        menuView.translatesAutoresizingMaskIntoConstraints = false
        menuView.stickToParentLayout(with: .zero)
    }
}
