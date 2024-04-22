//
//  TermsAndConditionsViewController.swift
//  NewsToDayApp
//
//  Created by Maksim Stogniy on 16.04.2024.
//

import UIKit

final class TermsAndConditionsViewController: UIViewController {
    
    private let presenter: TermsAndConditionsPresenterProtocol
    private let customView = TermsAndConditionsView()
    
    init(presenter: TermsAndConditionsPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCustomView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func setupCustomView() {
        view.addSubview(customView)
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.topAnchor),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        customView.delegate = self
    }

}

//MARK: - TermsAndConditionsViewDelegate
extension TermsAndConditionsViewController: TermsAndConditionsViewDelegate {
    func tappedBackButton() {
        presenter.dismissTermsAndConditionsVC()
    }
}

//MARK: - TermsAndConditionsPresenterViewProtocol
extension TermsAndConditionsViewController: TermsAndConditionsPresenterViewProtocol {
    
}

