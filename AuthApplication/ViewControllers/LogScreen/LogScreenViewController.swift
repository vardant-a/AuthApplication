//
//  LogScreenViewController.swift
//  AuthApplication
//
//  Created by Aleksei on 17.01.2023.
//

import UIKit

final class LogScreenViewController: UIViewController {
    
    // MARK: - Private lazy Properties
    
    private lazy var emailTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        
        return textField
    }()
    
    private lazy var passwordTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        
        return textField
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("LogIn", for: .normal)
        button.addTarget(self, action: #selector(tuppedLogInButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Life Cycles Methos

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
}

    // MARK: - Settings ViewController

private extension LogScreenViewController {
    func setupView() {
        view.backgroundColor = .yellow
        
        view.addSubview(emailTF)
        view.addSubview(passwordTF)
        view.addSubview(logInButton)
        
        setupLayout()
    }
}

    // MARK: - @Objc private Methods

private extension LogScreenViewController {
    @objc func tuppedLogInButton() {
        let vc = MainViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        present(vc, animated: true)
    }
}

    // MARK: - Layout

private extension LogScreenViewController {
    func setupLayout() {
        passwordTF.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTF.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            passwordTF.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        emailTF.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTF.bottomAnchor.constraint(equalTo: passwordTF.topAnchor, constant: -20),
            emailTF.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logInButton.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 20),
            logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
