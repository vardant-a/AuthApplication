//
//  MainViewController.swift
//  AuthApplication
//
//  Created by Aleksei on 17.01.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let networkManager = NetworkManager.shared
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log Out", for: .normal)
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.systemRed
        button.layer.cornerRadius = 12
        button.addTarget(self,
                         action: #selector(tuppedLogOutButton),
                         for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Life Cycles Methos

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
}

    // MARK: - Settings ViewController

private extension MainViewController {
    func setupView() {
        view.backgroundColor = .orange
        view.addSubview(logOutButton)
        setupLayout()
    }
}

    // MARK: - @Objc private Methods

private extension MainViewController {
    @objc func tuppedLogOutButton() {
        networkManager.logOut()
        
        dismiss(animated: true)
    }
}

    // MARK: - Layout

private extension MainViewController {
    func setupLayout() {
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logOutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logOutButton.heightAnchor.constraint(equalToConstant: 44),
            logOutButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}
