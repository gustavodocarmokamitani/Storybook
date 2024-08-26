//
//  MenuViewController.swift
//  UIKitPlayground
//
//  Created by Gustavo Kamitani on 20/08/24.
//

import UIKit

class MenuViewController: UIViewController {
    
    private var imageView: UIImageView?
    private var showImageButton: UIButton?
    private var changeBackgroundColorButton: UIButton?
    private var imageContainerView: UIView?
    private var changeIconLeftButton: UIButton?
    private var changeIconRightButton: UIButton?
    
    private let iconList = ["star", "heart", "moon", "sun.max", "cloud"]
    private var currentIconIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        setupMenu()
    }
    
    private func setupMenu() {
        var configButton = UIButton.Configuration.filled()
        configButton.baseBackgroundColor = .white
        configButton.baseForegroundColor = .black
        configButton.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        configButton.background.strokeColor = .black
        configButton.background.strokeWidth = 2
        configButton.background.cornerRadius = 10
        
        let notificationButton = UIButton(type: .system)
        notificationButton.configuration = configButton
        notificationButton.setTitle("Show Notification", for: .normal)
        notificationButton.addTarget(self, action: #selector(showNotification), for: .touchUpInside)
        
        changeBackgroundColorButton = UIButton(type: .system)
        changeBackgroundColorButton?.configuration = configButton
        changeBackgroundColorButton?.setTitle("Change Dark Mode", for: .normal)
        changeBackgroundColorButton?.addTarget(self, action: #selector(changeBackgroundColor), for: .touchUpInside)
        
        imageContainerView = UIView()
        imageContainerView?.layoutMargins = UIEdgeInsets.zero
        
        showImageButton = UIButton(type: .system)
        showImageButton?.configuration = configButton
        showImageButton?.setTitle("Show Image", for: .normal)
        showImageButton?.addTarget(self, action: #selector(showImage), for: .touchUpInside)
        
        imageView = UIImageView(image: UIImage(systemName: "star"))
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        imageView?.isHidden = true
        
        changeIconLeftButton = UIButton(type: .system)
        changeIconLeftButton?.configuration = configButton
        let leftIconImage = UIImage(systemName: "arrow.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 10))
        changeIconLeftButton?.setImage(leftIconImage, for: .normal)
        changeIconLeftButton?.addTarget(self, action: #selector(changeIconLeft), for: .touchUpInside)
        changeIconLeftButton?.isHidden = true

        changeIconRightButton = UIButton(type: .system)
        changeIconRightButton?.configuration = configButton
        let rightIconImage = UIImage(systemName: "arrow.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 10))
        changeIconRightButton?.setImage(rightIconImage, for: .normal)
        changeIconRightButton?.addTarget(self, action: #selector(changeIconLeft), for: .touchUpInside)
        changeIconRightButton?.isHidden = true
        
        notificationButton.translatesAutoresizingMaskIntoConstraints = false
        changeBackgroundColorButton?.translatesAutoresizingMaskIntoConstraints = false
        showImageButton?.translatesAutoresizingMaskIntoConstraints = false
        imageContainerView?.translatesAutoresizingMaskIntoConstraints = false
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        changeIconLeftButton?.translatesAutoresizingMaskIntoConstraints = false
        changeIconRightButton?.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(notificationButton)
        view.addSubview(changeBackgroundColorButton!)
        view.addSubview(imageContainerView!)
        view.addSubview(showImageButton!)
        view.addSubview(changeIconLeftButton!)
        view.addSubview(changeIconRightButton!)

        imageContainerView?.addSubview(imageView!)
        
        NSLayoutConstraint.activate([
            notificationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            notificationButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            changeBackgroundColorButton!.topAnchor.constraint(equalTo: notificationButton.bottomAnchor, constant: 10),
            changeBackgroundColorButton!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            imageContainerView!.topAnchor.constraint(equalTo: changeBackgroundColorButton!.bottomAnchor, constant: 30),
            imageContainerView!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            showImageButton!.leadingAnchor.constraint(equalTo: imageContainerView!.leadingAnchor),
            showImageButton!.centerYAnchor.constraint(equalTo: imageContainerView!.centerYAnchor),
            
            imageView!.leadingAnchor.constraint(equalTo: changeIconLeftButton!.trailingAnchor, constant: 10),
            imageView!.centerYAnchor.constraint(equalTo: imageContainerView!.centerYAnchor),
            imageView!.widthAnchor.constraint(equalToConstant: 20),
            imageView!.heightAnchor.constraint(equalToConstant: 20),
            
            changeIconLeftButton!.leadingAnchor.constraint(equalTo: showImageButton!.trailingAnchor, constant: 8),
            changeIconLeftButton!.centerYAnchor.constraint(equalTo: imageContainerView!.centerYAnchor),
            changeIconLeftButton!.heightAnchor.constraint(equalToConstant: 40),
                    
            changeIconRightButton!.leadingAnchor.constraint(equalTo: imageView!.trailingAnchor, constant: 10),
            changeIconRightButton!.centerYAnchor.constraint(equalTo: imageContainerView!.centerYAnchor),
            changeIconRightButton!.heightAnchor.constraint(equalToConstant: 40),
                    
            
        ])
    }
    
    @objc func showNotification() {
        let alert = UIAlertController(title: "Notification", message: "This is a simple notification", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func changeBackgroundColor() {
        if view.backgroundColor == .black {
            view.backgroundColor = .white
            changeBackgroundColorButton?.setTitle("Change Light Mode", for: .normal)
        } else {
            view.backgroundColor = .black
            changeBackgroundColorButton?.setTitle("Change Dark Mode", for: .normal)
        }
        updateButtonColors()
    }
    
    @objc func showImage() {
        if imageView!.isHidden {
            imageView!.isHidden = false
            changeIconLeftButton!.isHidden = false
            changeIconRightButton!.isHidden = false
            
            showImageButton?.setTitle("Close Image", for: .normal)
        } else {
            imageView!.isHidden = true
            showImageButton?.setTitle("Open Image", for: .normal)
            changeIconLeftButton!.isHidden = true
            changeIconRightButton!.isHidden = true
        }
    }
    
    @objc func updateButtonColors() {
        let newBackgroundColor: UIColor = view.backgroundColor == .white ? .black : .white
        let newForegroundColor: UIColor = view.backgroundColor == .white ? .white : .black
        let newStrokeColor: UIColor = view.backgroundColor == .white ? .black : .white
        
        func updateButtons(in containerView: UIView) {
            for subview in containerView.subviews where subview is UIButton {
                if let button = subview as? UIButton {
                    let currentTitle = button.currentTitle
                    var updatedConfig = UIButton.Configuration.filled()
                    updatedConfig.baseBackgroundColor = newBackgroundColor
                    updatedConfig.baseForegroundColor = newForegroundColor
                    updatedConfig.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
                    updatedConfig.background.strokeColor = newStrokeColor
                    updatedConfig.background.strokeWidth = 2
                    updatedConfig.background.cornerRadius = 10
                    
                    button.configuration = updatedConfig
                    button.setTitle(currentTitle, for: .normal)
                }
            }
        }
        
        // Atualizando os botões na view principal e na imageContainerView
        updateButtons(in: view)
        if let containerView = imageContainerView {
            updateButtons(in: containerView)
        }
    }
    
    @objc func changeIconLeft() {
        currentIconIndex = (currentIconIndex - 1 + iconList.count) % iconList.count
        imageView?.image = UIImage(systemName: iconList[currentIconIndex])
    }

    @objc func changeIconRight() {
        currentIconIndex = (currentIconIndex + 1) % iconList.count
        imageView?.image = UIImage(systemName: iconList[currentIconIndex])
    }

}
