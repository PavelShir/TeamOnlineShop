//
//  LabeledInput.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 20.04.2024.
//

import UIKit

protocol PickerViewRepresentable {
    var pickerViewTitle: String { get }
}

class CellClass: UITableViewCell {
    
}

class LabeledPickerView<T: PickerViewRepresentable>: UIView {
    
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
    
    private let selectionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Item", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
    
    var items: [T] = []
    
    var selectedItem: T?
    
    init(labelText: String, options: [T]) {
        super.init(frame: .zero)
        setupLabel(text: labelText)
        self.items = options
        layoutUI()
        selectionButton.addTarget(self, action: #selector(presentOptions), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabel(text: String) {
        label.text = text
    }
    
    private func layoutUI() {
        [label, selectionButton].forEach { hStack.addArrangedSubview($0) }
        addSubview(hStack)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.widthAnchor.constraint(lessThanOrEqualToConstant: 80),
        ])
        
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: topAnchor),
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            hStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    
    @objc private func presentOptions() {
        guard let topController = findTopViewController() else { return }
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for item in items {
            let action = UIAlertAction(title: item.pickerViewTitle, style: .default, handler: { [weak self] _ in
                self?.selectionButton.setTitle(item.pickerViewTitle, for: .normal)
                self?.selectedItem = item
            })
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        topController.present(alertController, animated: true)
    }
    
    private func findTopViewController() -> UIViewController? {
        var topController: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
        while topController?.presentedViewController != nil {
            topController = topController?.presentedViewController
        }
        return topController
    }
}
