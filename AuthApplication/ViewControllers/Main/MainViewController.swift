//
//  MainViewController.swift
//  AuthApplication
//
//  Created by Aleksei on 17.01.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LogOut", for: .normal)
        button.addTarget(self, action: #selector(tuppedLogOutButton), for: .touchUpInside)
        
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

    }
}

    // MARK: - Layout

private extension MainViewController {
    func setupLayout() {
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logOutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
