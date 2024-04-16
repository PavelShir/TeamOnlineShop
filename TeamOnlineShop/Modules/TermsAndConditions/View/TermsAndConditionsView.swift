//
//  TermsAndConditionsView.swift
//  NewsToDayApp
//
//  Created by Maksim Stogniy on 16.04.2024.
//

import UIKit

protocol TermsAndConditionsViewDelegate: AnyObject {
    func tappedBackButton()
}

final class TermsAndConditionsView: UIView {
    
    weak var delegate: TermsAndConditionsViewDelegate?
    
    private let title: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(named: Colors.blackPrimary)
        label.numberOfLines = 1
        label.font = UIFont.TextFont.Screens.title
        label.lineBreakMode = .byTruncatingTail
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var termsText: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.text = ""
        textView.textColor = UIColor(named: Colors.blackPrimary)
        textView.font = UIFont.TextFont.Screens.text
        textView.textAlignment = .left
        textView.showsVerticalScrollIndicator = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private var backButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.setBackgroundImage(UIImage.Icons.arrowLeft, for: .normal)
        button.tintColor = UIColor(named: Colors.greyPrimary)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setViews()
        layoutViews()
    }
    
    func setViews() {
        setUpViews()
        backgroundColor = .white
        [
            title,
            termsText,
            backButton,
        ].forEach { addSubview($0) }
    }
    
    func layoutViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: title.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 20)
        ])

        NSLayoutConstraint.activate([
            termsText.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            termsText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            termsText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            termsText.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUpViews(){
        title.text = "Terms & Conditions"
        termsText.text = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum pellentesque lectus enim, ut tristique orci eleifend vitae. Ut sed urna dolor. Maecenas nunc nisi, tristique cursus facilisis eget, ultrices et felis. Nam auctor felis nunc, luctus egestas magna finibus at. Mauris eu laoreet risus, et scelerisque ex. Vivamus pulvinar eros eget posuere eleifend. Cras velit mi, tristique ut nisl ut, suscipit pulvinar ipsum. Nulla porta, tellus et venenatis porta, quam ligula malesuada erat, a viverra nulla neque ornare nunc. Nulla at felis semper, rutrum ipsum quis, egestas leo. Integer mi risus, lacinia id lorem in, gravida luctus sem. Fusce at metus ut odio tristique vulputate eu maximus mi.

        Sed quis lorem at leo pretium maximus sit amet vitae velit. Nullam maximus lectus eu ligula egestas, quis congue dolor dictum. Sed vitae mollis ipsum. Phasellus convallis nisi vitae tincidunt hendrerit. Vestibulum ut lorem nec libero tempor pretium. Curabitur venenatis dui nec nisl aliquam, eget volutpat nisi luctus. Proin accumsan dolor ex, a pellentesque lacus pellentesque sed. Mauris suscipit dapibus sagittis. Nam finibus mauris posuere tortor sollicitudin aliquam. Etiam vel quam nunc.

        Mauris dignissim ultrices velit id vestibulum. Etiam hendrerit lectus id lorem scelerisque dictum vel eu velit. Praesent quis quam elit. Nulla facilisi. Pellentesque et erat a mi rhoncus consectetur eget eget arcu. Integer ultricies, orci nec tempor commodo, leo risus hendrerit orci, vitae gravida lectus eros ut sapien. Vestibulum pulvinar dolor vitae erat pretium, vel efficitur nunc ultrices. Duis cursus felis vel est auctor iaculis. Duis lorem lorem, faucibus eu ornare quis, pulvinar sit amet odio.

        Pellentesque bibendum nunc ut tincidunt vestibulum. Ut nec augue vel tellus sagittis convallis. Fusce congue nisi rutrum purus porttitor eleifend. Suspendisse aliquam, libero in placerat accumsan, nisl tellus mollis tortor, vel auctor dolor urna in risus. Nulla fringilla mollis feugiat. Cras est enim, eleifend vitae posuere nec, vulputate ac magna. Sed faucibus ante eget nibh tincidunt iaculis.

        Nullam eget nunc pharetra, malesuada augue nec, rutrum est. Nam condimentum, libero id interdum convallis, libero sem vestibulum risus, id sodales arcu lorem ac nulla. Nulla molestie, ante eu tristique placerat, mauris risus efficitur justo, eget fringilla enim urna blandit lorem. Phasellus ipsum diam, molestie a risus facilisis, ullamcorper convallis nunc. Quisque varius, justo nec interdum aliquet, nisi nunc tincidunt sem, at laoreet sapien neque ac diam. Sed sagittis eleifend eros, vel elementum felis lacinia id. Fusce vel tincidunt nulla, quis suscipit nisi. Suspendisse vitae cursus mauris. Morbi id ullamcorper mauris. Maecenas blandit aliquet mauris. Nunc semper tempor nunc, id dictum quam bibendum eu. Vestibulum laoreet, mauris sed tristique malesuada, urna nulla convallis lectus, ut interdum ligula ex in turpis. Praesent sit amet varius nisi. Etiam sagittis vel neque a bibendum. Sed malesuada nisl sed semper auctor. Nullam rhoncus sollicitudin elit non convallis.
"""
        
        backButton.addTarget(nil, action: #selector(backTapped), for: .touchUpInside)
    }
    
    @objc private func backTapped(){
        delegate?.tappedBackButton()
    }
}
