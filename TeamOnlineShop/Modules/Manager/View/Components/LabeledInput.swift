//
//  LabeledInput.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 20.04.2024.
//

import UIKit

class LabeledInputView: UIView {
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.blackPrimary)
        label.numberOfLines = 1
        label.font = UIFont.TextFont.Screens.ManagerScreen.propertyLabel
        label.lineBreakMode = .byTruncatingTail
        label.sizeToFit()
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textField: UITextField = {
        let input = UITextField()
        input.borderStyle = .roundedRect
        input.clearButtonMode = .always
        input.textColor = UIColor(named: Colors.blackPrimary)
        input.font =  UIFont.TextFont.Screens.ManagerScreen.propertyValue
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    private let hStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var text: String? {
        get { return textField.text }
        set { textField.text = newValue }
    }
    
    init(labelText: String, placeholder: String) {
        super.init(frame: .zero)
        setupLabel(text: labelText)
        setupTextField(placeholder: placeholder)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabel(text: String) {
        label.text = text
    }
    
    private func setupTextField(placeholder: String) {
        textField.placeholder = placeholder
    }
    
    private func layoutUI() {
        [label, textField].forEach { hStack.addArrangedSubview($0) }
        addSubviews(hStack)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.widthAnchor.constraint(lessThanOrEqualToConstant: 80),
        ])
        
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 40),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: topAnchor),
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            hStack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
