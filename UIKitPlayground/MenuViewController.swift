//
//  MenuViewController.swift
//  UIKitPlayground
//
//  Created by Gustavo Kamitani on 20/08/24.
//

import UIKit

class MenuViewController: UIViewController, UITextFieldDelegate {
    
    private var labelStorybook: UILabel?
    private var notificationButton: UIButton?
    private var imageView: UIImageView?
    private var showImageButton: UIButton?
    private var changeBackgroundColorButton: UIButton?
    private var imageContainerView: UIView?
    private var changeIconLeftButton: UIButton?
    private var changeIconRightButton: UIButton?
    private var messageButton: UIButton?
    private var messageTextField: UITextField!
    private var messageAlert: String = "This is a simple notification"
    private var animationButton: UIButton?
    private var slideOpacityButton: UISlider?
    private var progressButton: UIButton?
    private var progressView : UIProgressView?
    
    var notificationButtonClicked: Bool = false
    var changeBackgroundColorButtonClicked: Bool = false
    var showImageButtonClicked: Bool = false
    var messageButtonClicked: Bool = false
    var animationButtonClicked: Bool = false
    var slideOpacityButtonCliked: Bool = false
    
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
    
        labelStorybook = UILabel()
        labelStorybook?.text = "Storybook"
        labelStorybook?.textColor = UIColor.white
        labelStorybook?.textAlignment = .center
        labelStorybook?.font = UIFont.systemFont(ofSize: 24)
        
        notificationButton = UIButton(type: .system)
        notificationButton?.configuration = configButton
        notificationButton?.setTitle("Show Notification", for: .normal)
        notificationButton?.addTarget(self, action: #selector(showNotification), for: .touchUpInside)
        
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
        changeIconRightButton?.addTarget(self, action: #selector(changeIconRight), for: .touchUpInside)
        changeIconRightButton?.isHidden = true
        
        messageTextField = UITextField()
        messageTextField?.borderStyle = .roundedRect
        messageTextField?.backgroundColor = .black
        messageTextField?.textColor = .white
        messageTextField?.borderStyle = .none
        messageTextField?.layer.borderColor = UIColor.white.cgColor
        messageTextField?.layer.borderWidth = 2
        messageTextField?.layer.cornerRadius = 10.0
        messageTextField?.placeholder = "Message here..."
        messageTextField?.attributedPlaceholder = NSAttributedString(string: "Message here...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        messageTextField?.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: messageTextField!.frame.height))
        messageTextField?.leftViewMode = .always
        messageTextField?.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: messageTextField!.frame.height))
        messageTextField?.rightViewMode = .always
        messageTextField?.delegate = self
        
        messageButton = UIButton(type: .system)
        messageButton?.configuration = configButton
        messageButton?.setTitle("Send", for: .normal)
        messageButton?.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        
        animationButton = UIButton(type: .system)
        animationButton?.configuration = configButton
        animationButton?.setTitle("Animation", for: .normal)
        animationButton?.addTarget(self, action: #selector(animationButtons), for: .touchUpInside)
        
        slideOpacityButton = UISlider()
        slideOpacityButton?.layer.borderWidth = 2
        slideOpacityButton?.layer.borderColor = UIColor.white.cgColor
        slideOpacityButton?.backgroundColor = UIColor.white
        slideOpacityButton?.layer.borderWidth = 2
        slideOpacityButton?.layer.cornerRadius = 10.0
        slideOpacityButton?.minimumValue = 0.1
        slideOpacityButton?.maximumValue = 1
        slideOpacityButton?.value = 1
        slideOpacityButton?.thumbTintColor = UIColor.black
        slideOpacityButton?.minimumTrackTintColor = UIColor.black
        slideOpacityButton?.maximumTrackTintColor = UIColor.black
        slideOpacityButton?.addTarget(self, action: #selector(opacitySliderChanged(_:)), for: .valueChanged)
        
        progressButton = UIButton(type: .system)
        progressButton!.configuration = configButton
        progressButton!.setTitle("Increase Progress", for: .normal)
        progressButton!.addTarget(self, action: #selector(progressButtonTapped), for: .touchUpInside)
        view.addSubview(progressButton!)
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView!.progress = 0.0
        progressView!.tintColor = .systemGreen
        view.addSubview(progressView!)
        
        labelStorybook?.translatesAutoresizingMaskIntoConstraints = false
        notificationButton?.translatesAutoresizingMaskIntoConstraints = false
        changeBackgroundColorButton?.translatesAutoresizingMaskIntoConstraints = false
        showImageButton?.translatesAutoresizingMaskIntoConstraints = false
        imageContainerView?.translatesAutoresizingMaskIntoConstraints = false
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        changeIconLeftButton?.translatesAutoresizingMaskIntoConstraints = false
        changeIconRightButton?.translatesAutoresizingMaskIntoConstraints = false
        messageButton?.translatesAutoresizingMaskIntoConstraints = false
        messageTextField?.translatesAutoresizingMaskIntoConstraints = false
        animationButton?.translatesAutoresizingMaskIntoConstraints = false
        slideOpacityButton?.translatesAutoresizingMaskIntoConstraints = false
        progressButton?.translatesAutoresizingMaskIntoConstraints = false
        progressView?.translatesAutoresizingMaskIntoConstraints = false
        imageContainerView?.addSubview(imageView!)
        
        view.addSubview(labelStorybook!)
        view.addSubview(notificationButton!)
        view.addSubview(changeBackgroundColorButton!)
        view.addSubview(imageContainerView!)
        view.addSubview(showImageButton!)
        view.addSubview(changeIconLeftButton!)
        view.addSubview(changeIconRightButton!)
        view.addSubview(messageButton!)
        view.addSubview(messageTextField!)
        view.addSubview(animationButton!)
        view.addSubview(slideOpacityButton!)
        view.addSubview(progressButton!)
        view.addSubview(progressView!)
        
        NSLayoutConstraint.activate([
            labelStorybook!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            labelStorybook!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            labelStorybook!.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            notificationButton!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            notificationButton!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            notificationButton!.widthAnchor.constraint(equalToConstant: 200),
            
            changeBackgroundColorButton!.topAnchor.constraint(equalTo: notificationButton!.bottomAnchor, constant: 10),
            changeBackgroundColorButton!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            changeBackgroundColorButton!.widthAnchor.constraint(equalToConstant: 200),
            
            imageContainerView!.topAnchor.constraint(equalTo: changeBackgroundColorButton!.bottomAnchor, constant: 30),
            imageContainerView!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            showImageButton!.leadingAnchor.constraint(equalTo: imageContainerView!.leadingAnchor),
            showImageButton!.centerYAnchor.constraint(equalTo: imageContainerView!.centerYAnchor),
            showImageButton!.widthAnchor.constraint(equalToConstant: 200),
            
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
            
            messageTextField!.topAnchor.constraint(equalTo: showImageButton!.bottomAnchor, constant: 16),
            messageTextField!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            messageTextField!.heightAnchor.constraint(equalToConstant: 40),
            messageTextField!.widthAnchor.constraint(equalToConstant: 200),
            
            messageButton!.topAnchor.constraint(equalTo: showImageButton!.bottomAnchor, constant: 16),
            messageButton!.leadingAnchor.constraint(equalTo: messageTextField!.trailingAnchor, constant: 16),
            
            animationButton!.topAnchor.constraint(equalTo: messageButton!.bottomAnchor, constant: 16),
            animationButton!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            animationButton!.widthAnchor.constraint(equalToConstant: 200),
            
            slideOpacityButton!.topAnchor.constraint(equalTo: animationButton!.bottomAnchor, constant: 16),
            slideOpacityButton!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            slideOpacityButton!.widthAnchor.constraint(equalToConstant: 200),
            slideOpacityButton!.heightAnchor.constraint(equalToConstant: 40),
            
            progressButton!.topAnchor.constraint(equalTo: slideOpacityButton!.bottomAnchor, constant: 16),
            progressButton!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            progressButton!.widthAnchor.constraint(equalToConstant: 200),
            progressButton!.heightAnchor.constraint(equalToConstant: 40),
            
            progressView!.topAnchor.constraint(equalTo: progressButton!.bottomAnchor, constant: 16),
            progressView!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            progressView!.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc func showNotification() {
        let alert = UIAlertController(title: "Notification", message: messageAlert, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        notificationButtonClicked == false ? incrementProgress() : nil
        notificationButtonClicked = true
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
        changeBackgroundColorButtonClicked == false ? incrementProgress() : nil
        changeBackgroundColorButtonClicked = true
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
        showImageButtonClicked == false ? incrementProgress() : nil
        showImageButtonClicked = true
    }
    
    @objc func updateButtonColors() {
        let newBackgroundColor: UIColor = view.backgroundColor == .white ? .black : .white
        let newForegroundColor: UIColor = view.backgroundColor == .white ? .white : .black
        let newStrokeColor: UIColor = view.backgroundColor == .white ? .black : .white
        let newTextColor: UIColor = view.backgroundColor == .black ? .white : .black
        let newPlaceholderBackgroundColor: UIColor = view.backgroundColor == .white ? .white : .black
        let newPlaceholderColor: UIColor = view.backgroundColor == .white ? .black : .white
        let newSliderTrackColor: UIColor = view.backgroundColor == .black ? .black : .white
        
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
        
        func updateTextFields(in containerView: UIView) {
            for subview in containerView.subviews where subview is UITextField {
                if let textField = subview as? UITextField {
                    textField.backgroundColor = newPlaceholderBackgroundColor
                    textField.textColor = newTextColor
                    textField.layer.borderColor = newStrokeColor.cgColor
                    textField.attributedPlaceholder = NSAttributedString(
                        string: textField.placeholder ?? "",
                        attributes: [NSAttributedString.Key.foregroundColor: newPlaceholderColor]
                    )
                }
            }
        }
        
        func updateSliders(in containerView: UIView) {
            for subview in containerView.subviews where subview is UISlider {
                if let slider = subview as? UISlider {
                    slider.layer.borderColor = newStrokeColor.cgColor
                    slider.layer.borderWidth = 2
                    slider.layer.cornerRadius = 10.0
                    slider.thumbTintColor = newSliderTrackColor
                    slider.minimumTrackTintColor = newSliderTrackColor
                    slider.backgroundColor = newBackgroundColor
                }
            }
        }
        
        func updateLabel(in containerView: UIView) {
            // Itera sobre todas as subviews da containerView
            for subview in containerView.subviews where subview is UILabel {
                // Verifica se a subview é uma UILabel
                if let label = subview as? UILabel {
                    // Atualiza a cor do texto da UILabel
                    label.textColor = newBackgroundColor
                }
            }
        }
        
        // Atualizando os botões e textFields na view principal e na imageContainerView
        updateButtons(in: view)
        updateTextFields(in: view)
        updateSliders(in: view)
        updateLabel(in: view)
        if let containerView = imageContainerView {
            updateButtons(in: containerView)
            updateTextFields(in: containerView)
            updateLabel(in: containerView)
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
    
    @objc func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 20 // Número máximo de caracteres permitidos
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    @objc func sendMessage() {
        // Verifica se o texto no messageTextField está vazio ou contém apenas espaços em branco
        guard let message = messageTextField?.text?.trimmingCharacters(in: .whitespacesAndNewlines), !message.isEmpty else {
            // Se estiver vazio, exibe um alerta
            let emptyAlert = UIAlertController(title: "Error", message: "Message cannot be empty.", preferredStyle: .alert)
            emptyAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(emptyAlert, animated: true, completion: nil)
            return
        }
        
        // Se não estiver vazio, exibe a mensagem normalmente
        messageAlert = message
        let alert = UIAlertController(title: "Message", message: messageAlert, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        // Limpa o campo de texto
        messageTextField?.text = ""
        
        messageButtonClicked == false ? incrementProgress() : nil
        messageButtonClicked = true
    }
    
    
    @objc func animationButtons() {
        let duration = 0.5
        let delay = 0.0
        let options: UIView.AnimationOptions = [.curveEaseInOut]
        let transformScale = CGAffineTransform(scaleX: 1.1, y: 1.1)
        let transformIdentity = CGAffineTransform.identity
        
        // Função para animar um botão ou text field específico
        func animateView(_ view: UIView?) {
            guard let view = view else { return }
            UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
                view.transform = transformScale
            }, completion: { _ in
                UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
                    view.transform = transformIdentity
                }, completion: nil)
            })
        }
        // Anima todos os botões
        animateView(notificationButton)
        animateView(changeBackgroundColorButton)
        animateView(showImageButton)
        animateView(changeIconLeftButton)
        animateView(changeIconRightButton)
        animateView(messageButton)
        animateView(animationButton)
        animateView(progressButton)
        
        // Anima todos os text fields (adicione aqui seus text fields)
        animateView(messageTextField)
        animateView(slideOpacityButton)
        
        animationButtonClicked == false ? incrementProgress() : nil
        animationButtonClicked = true
    }
    
    @objc func opacitySliderChanged(_ sender: UISlider) {
        let opacityValue = CGFloat(sender.value)
        
        let buttons = [notificationButton, changeBackgroundColorButton, showImageButton, changeIconLeftButton, changeIconRightButton, messageButton, animationButton, slideOpacityButton, progressButton, progressView]
        for button in buttons {
            button?.alpha = opacityValue
        }
        
        messageTextField.alpha = opacityValue
        
        imageView?.alpha = opacityValue
        
        slideOpacityButtonCliked == false ? incrementProgress() : nil
        slideOpacityButtonCliked = true
    }
    
    func incrementProgress() {
        let currentProgress = progressView?.progress ?? 0.0
        let newProgress = min(currentProgress + 0.15, 1.0)
        
        progressView?.setProgress(newProgress, animated: true)
        
        if newProgress >= 1.0 {
            progressButton?.setTitle("Completed", for: .normal)
        }
    }
    
    @objc func progressButtonTapped() {
        incrementProgress()
    }
}

