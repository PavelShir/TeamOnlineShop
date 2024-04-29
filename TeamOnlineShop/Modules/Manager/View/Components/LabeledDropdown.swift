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

protocol LabeledDropdownViewDelegate: AnyObject {
    func didSelectItem<T: PickerViewRepresentable>(_ item: T)
}

class LabeledDropdownView<T: PickerViewRepresentable>: UIView where T: Equatable {
    
    weak var delegate: LabeledDropdownViewDelegate?
    
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
        button.contentHorizontalAlignment = .fill
        
        var config = UIButton.Configuration.filled()
        config.baseForegroundColor = UIColor(named: Colors.blackPrimary)
        config.title = "Select category"
        config.attributedTitle = AttributedString("Select category", attributes: AttributeContainer([NSAttributedString.Key.font: UIFont.TextFont.Screens.ManagerScreen.propertyValue]))

        let symbolConfig = UIImage.SymbolConfiguration(scale: .small)
        config.preferredSymbolConfigurationForImage = symbolConfig
        config.image = UIImage.Icons.chevronDown
        config.imagePlacement = .trailing
        
        config.background.backgroundColor = .clear
        config.background.strokeColor = UIColor(named: Colors.greyPrimary)?.withAlphaComponent(0.5)
        config.background.strokeWidth = 0.5
        config.background.cornerRadius = 4

        config.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        button.configuration = config
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
    
    var items: [T] = [] {
        didSet {
            configureMenu()
        }
    }
    
    var selectedItem: T? {
        didSet {
            configureMenu()
            updateButtonTitle()
        }
    }
    
    private var actions: [UIAction] = []
    private var menuItems: [UIMenuElement] = []
    
    init(labelText: String, options: [T]) {
        super.init(frame: .zero)
        setupLabel(text: labelText)
        self.items = options
        layoutUI()
        configureMenu()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabel(text: String) {
        label.text = text
//        selectionButton.setTitle("Select \(text)", for: .normal)
        var currentConfig = selectionButton.configuration
        let attributedTitle = AttributedString("Select \(text)", attributes: AttributeContainer([
            .font: UIFont.TextFont.Screens.ManagerScreen.propertyValue,
            .foregroundColor: UIColor(named: Colors.blackPrimary) ?? .black
        ]))
        currentConfig?.attributedTitle = attributedTitle
        selectionButton.configuration = currentConfig
    }
    
    private func layoutUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        [label, selectionButton].forEach { hStack.addArrangedSubview($0) }
        addSubview(hStack)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.widthAnchor.constraint(lessThanOrEqualToConstant: 80),
            selectionButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: topAnchor),
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            hStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func configureMenu() {
        actions = items.map { item in
            UIAction(title: item.pickerViewTitle, state: (item == selectedItem ? .on : .off)) { [weak self] action in
                self?.selectedItem = item
                self?.updateButtonTitle()
                self?.delegate?.didSelectItem(item)
            }
        }
        selectionButton.menu = UIMenu(title: "", children: actions)
        selectionButton.showsMenuAsPrimaryAction = true
    }
    
    private func updateButtonTitle() {
        guard let selectedItem = selectedItem else {
            selectionButton.setTitle("Select category", for: .normal)
            return
        }
        var currentConfig = selectionButton.configuration
        let attributedTitle = AttributedString(selectedItem.pickerViewTitle, attributes: AttributeContainer([
            .font: UIFont.TextFont.Screens.ManagerScreen.propertyValue,
            .foregroundColor: UIColor(named: Colors.blackPrimary) ?? .black
        ]))
        currentConfig?.attributedTitle = attributedTitle
        selectionButton.configuration = currentConfig
    }
}
