//
//  LabeledInput.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 20.04.2024.
//

import UIKit

class LabeledTextView: UIView {
    private let labelContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    
    private let textView: UITextView = {
        let input = UITextView()
        input.textColor = UIColor(named: Colors.blackPrimary)
        input.font =  UIFont.TextFont.Screens.ManagerScreen.propertyValue
        input.layer.borderWidth = 1.0
        input.layer.borderColor = UIColor(named: Colors.greyLighter)?.cgColor
        input.layer.cornerRadius = 4.0
        input.textContainerInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 10)
            
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    private let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "multiply.circle.fill"), for: .normal)
        button.tintColor = UIColor(named: Colors.greyPrimary)?.withAlphaComponent(0.5)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let hStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: Colors.greyPrimary)?.withAlphaComponent(0.5)
        label.font =  UIFont.TextFont.Screens.ManagerScreen.propertyValue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var text: String? {
        get { return textView.text }
        set {
            textView.text = newValue
            placeholderLabel.isHidden = !textView.text.isEmpty
            clearButton.isHidden = textView.text.isEmpty
        }
    }
    
    init(labelText: String, placeholder: String) {
        super.init(frame: .zero)
        setupLabel(text: labelText)
        setupTextView(placeholder: placeholder)
        layoutUI()
        addObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(textViewDidChange(_:)), name: UITextView.textDidChangeNotification, object: textView)
    }
    
    @objc private func textViewDidChange(_ notification: Notification) {
        placeholderLabel.isHidden = !textView.text.isEmpty
        clearButton.isHidden = textView.text.isEmpty
    }
    
    @objc private func clearText() {
        textView.text = ""
        placeholderLabel.isHidden = false
        clearButton.isHidden = true
    }
    
    private func setupLabel(text: String) {
        label.text = text
    }
    
    private func setupTextView(placeholder: String) {
        textView.addSubview(placeholderLabel)
        textView.addSubview(clearButton)
        placeholderLabel.text = placeholder
        placeholderLabel.numberOfLines = 0
        placeholderLabel.font = textView.font
        clearButton.addTarget(self, action: #selector(clearText), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: textView.topAnchor, constant: 10),
            placeholderLabel.leadingAnchor.constraint(equalTo: textView.leadingAnchor, constant: 10),
            
            // Кнопка не отображается
            clearButton.topAnchor.constraint(equalTo: textView.topAnchor, constant: 10),
            clearButton.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -10),
            clearButton.widthAnchor.constraint(equalToConstant: 15),
            clearButton.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    private func layoutUI() {
        labelContainerView.addSubview(label)
        [labelContainerView, textView].forEach { hStack.addArrangedSubview($0) }
        addSubviews(hStack)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: labelContainerView.topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: labelContainerView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: labelContainerView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: labelContainerView.bottomAnchor),
            labelContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            textView.heightAnchor.constraint(equalToConstant: textView.font!.lineHeight * 6),
            textView.topAnchor.constraint(equalTo: topAnchor),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: topAnchor),
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            hStack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
