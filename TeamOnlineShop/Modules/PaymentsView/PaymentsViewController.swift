//
//  PaymentsViewController.swift
//  TeamOnlineShop
//
//  Created by Сергей П on 20.04.2024.
//

import UIKit

class PaymentsViewController: UIViewController {
    
    var onContinue: (() -> Void)?
    //Временные значения
    let titleText = "Congrats! Your payment is successfully"
    let text = "Track your order or just chat direcktly to the seller."
    
    //MARK: - UI
    
    private lazy var closeButton: UIButton = {
        let element = UIButton(type: .system)
        element.setImage(UIImage.Icons.remove, for: .normal)
        element.tintColor = UIColor(named: Colors.blackLight)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var checkImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage.Icons.checkmarkSealFill
        element.tintColor = UIColor(named: Colors.greenPrimary)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var checkShadowImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage.Icons.checkmarkSealFill
        element.tintColor = UIColor(named: Colors.greyLighter)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var titleLabel: UILabel = {
        let element = UILabel()
        element.text = titleText
        element.font = UIFont.TextFont.Screens.PaymentSuccess.title
        element.numberOfLines = 0
        element.textAlignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var textLabel: UILabel = {
        let element = UILabel()
        element.text = text
        element.font = UIFont.TextFont.Screens.PaymentSuccess.text
        element.numberOfLines = 0
        element.textAlignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var continueButton = CustomButton(label: "Continue", size: CustomButton.Size.normal, type: CustomButton.ButtonType.primary)
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        setupConstraints()
    }
    
    //MARK: - Set Views
    
    private func setViews() {
        view.backgroundColor = .white
        
        view.addSubview(closeButton)
        view.addSubview(checkShadowImageView)
        checkShadowImageView.addSubview(checkImageView)
        view.addSubview(titleLabel)
        view.addSubview(textLabel)
        view.addSubview(continueButton)
        
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)

    }
    
    //MARK: - Button Tapped
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true) {
            self.onContinue?()
        }
    }
    
    @objc private func continueButtonTapped() {
        dismiss(animated: true) {
            self.onContinue?()
        }
    }
}

//MARK: - Setup Constraints

extension PaymentsViewController {
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            checkShadowImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            checkShadowImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -65),
            checkShadowImageView.heightAnchor.constraint(equalToConstant: 130),
            checkShadowImageView.widthAnchor.constraint(equalToConstant: 130),
            
            checkImageView.centerXAnchor.constraint(equalTo: checkShadowImageView.centerXAnchor),
            checkImageView.centerYAnchor.constraint(equalTo: checkShadowImageView.centerYAnchor),
            checkImageView.heightAnchor.constraint(equalToConstant: 120),
            checkImageView.widthAnchor.constraint(equalToConstant: 120),
            
            titleLabel.topAnchor.constraint(equalTo: checkShadowImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continueButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
}
