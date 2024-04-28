//
//  AddressSelector.swift
//  TeamOnlineShop
//
//  Created by  Maksim Stogniy on 28.04.2024.
//

import UIKit
enum Address: CaseIterable {
    case usa
    case europe
    case russia
    case other

    var pickerViewTitle: String {
        switch self {
        case .usa:
            return "USA, Washington DC, Main St. 1"
        case .europe:
            return "France, Paris, 9 rue Cazade"
        case .russia:
            return "Russia, Moscow, Red Square 2"
        case .other:
            return "Timbuktu, Unknown place X"
        }
    }
}

class AddressSelector: UIButton {
    var items: [Address] = Address.allCases {
        didSet {
            configureMenu()
        }
    }

    // Выбранный элемент
    var selectedItem: Address? {
        didSet {
            configureMenu()
            updateButtonTitle()
        }
    }
    
    // Инициализация
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    private func commonInit() {
        configureButton()
        configureMenu()
    }
    
    private func configureButton() {
        self.contentHorizontalAlignment = .fill
        
        var config = UIButton.Configuration.filled()
        config.baseForegroundColor = UIColor(named: Colors.blackPrimary)
        config.title = "Select address"
        config.attributedTitle = AttributedString("Select address", attributes: AttributeContainer([NSAttributedString.Key.font: UIFont.TextFont.Screens.ManagerScreen.propertyValue]))

        let symbolConfig = UIImage.SymbolConfiguration(scale: .small)
        config.preferredSymbolConfigurationForImage = symbolConfig
        config.image = UIImage.Icons.chevronDown
        config.imagePlacement = .trailing
        
        config.background.backgroundColor = .clear
        config.background.strokeColor = .clear
        config.background.strokeWidth = 0

        config.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        self.configuration = config
//        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
//    private var actions: [UIAction] = []
//    private var menuItems: [UIMenuElement] = []
    
    private func configureMenu() {
        let actions = items.map { item in
            UIAction(title: item.pickerViewTitle, state: (item == selectedItem ? .on : .off)) { [weak self] action in
                self?.selectedItem = item
                self?.updateButtonTitle()
            }
        }
        self.menu = UIMenu(title: "", children: actions)
        self.showsMenuAsPrimaryAction = true
    }
    
    private func updateButtonTitle() {
        guard let selectedItem = selectedItem?.pickerViewTitle  else {
            self.setTitle("Select address", for: .normal)
            return
        }
        var currentConfig = self.configuration
        let attributedTitle = AttributedString(selectedItem, attributes: AttributeContainer([
            .font: UIFont.TextFont.Screens.ManagerScreen.propertyValue,
            .foregroundColor: UIColor(named: Colors.blackPrimary) ?? .black
        ]))
        currentConfig?.attributedTitle = attributedTitle
        self.configuration = currentConfig
    }
}

