//
//  ViewController.swift
//  UIKitPlayground
//
//  Created by Gustavo Kamitani on 20/08/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let goToMenuButton = UIButton(type: .system)
               goToMenuButton.setTitle("Go to Menu", for: .normal)
               goToMenuButton.addTarget(self, action: #selector(navigateToMenu), for: .touchUpInside)
               
               view.addSubview(goToMenuButton)
        
        goToMenuButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            goToMenuButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 250),
            goToMenuButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            goToMenuButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    @objc func navigateToMenu() {
            let menuVC = MenuViewController()
            navigationController?.pushViewController(menuVC, animated: false)
        }
}

