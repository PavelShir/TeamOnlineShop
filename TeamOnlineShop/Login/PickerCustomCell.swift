//
//  PickerCustomCell.swift
//  TeamOnlineShop
//
//  Created by Павел Широкий on 24.04.2024.
//

import UIKit

class PickerCustomCell: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var userType: UserType = .user
    var didSelectValue: ((UserType) -> Void)?
    let pickerView = UIPickerView()
    let values = ["Клиент", "Менеджер"]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        pickerView.dataSource = self
        pickerView.delegate = self
        contentView.addSubview(pickerView)
        
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pickerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            pickerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            pickerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            pickerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            pickerView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return values[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedValue = values[row]
        userType = UserType(rawValue: selectedValue) ?? .user
        didSelectValue?(userType)
    }
}



