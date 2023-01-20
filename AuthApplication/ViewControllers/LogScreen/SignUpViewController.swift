//
//  SignUpViewController.swift
//  AuthApplication
//
//  Created by Aleksei on 17.01.2023.
//

import UIKit
//import FirebaseAuth
//import Firebase

final class SignUpViewController: UIViewController {
    
    private let networkManager = NetworkManager.shared
    
    // MARK: - Private lazy Properties
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "LogoSVG")
        
        return imageView
    }()
    
    private lazy var emailTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .gray
        
        return textField
    }()
    
    private lazy var passwordTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .gray
        
        return textField
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 12
        button.addTarget(self,
                         action: #selector(tuppedSignUpButton),
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

private extension SignUpViewController {
    func setupView() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        view.addSubview(imageView)
        view.addSubview(emailTF)
        view.addSubview(passwordTF)
        view.addSubview(signUpButton)
        
        setupLayout()
    }
}

    // MARK: - @Objc private Methods

private extension SignUpViewController {
    @objc func tuppedSignUpButton() {
        if checkDataTF() {
            guard let email = emailTF.text else { return }
            guard let password = emailTF.text else { return }
            
            networkManager.createNewUser(email: email, password: password)
            dismiss(animated: true)
        } else {
            showAlert("Error")
        }
    }
}

    // MARK: - Private Methods

private extension SignUpViewController {
    func checkDataTF() -> Bool {
        if emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            print("""
                Ошибка, login - \(emailTF.text ?? "Log"),
                password - \(passwordTF.text ?? "pass")
                """)
            return false
        }
        
        print("""
            Отлично, login - \(emailTF.text ?? "Log"),
            password - \(passwordTF.text ?? "pass")
            """)
        
        return true
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(
            title: message,
            message: nil,
            preferredStyle: .alert
        )
        let ok = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
}

    // MARK: - Layout

private extension SignUpViewController {
    func setupLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        passwordTF.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTF.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            passwordTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTF.heightAnchor.constraint(equalToConstant: 44),
            passwordTF.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        emailTF.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTF.bottomAnchor.constraint(equalTo: passwordTF.topAnchor, constant: -20),
            emailTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTF.heightAnchor.constraint(equalToConstant: 44),
            emailTF.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 20),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 44),
            signUpButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}
