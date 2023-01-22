//
//  SignInViewController.swift
//  AuthApplication
//
//  Created by Aleksei on 17.01.2023.
//

import UIKit


final class SignInViewController: UIViewController {
    
    private let networkManager = NetworkManager.shared
    
    // MARK: - Private lazy Properties
    
    private lazy var registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Registration", for: .normal)
        button.tintColor = .systemGray
        button.backgroundColor = UIColor.black
        button.layer.cornerRadius = 8
        button.addTarget(self,
                         action: #selector(tuppedRegistrationButton),
                         for: .touchUpInside)
        
        return button
    }()
    
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
        button.setTitle("Sign In", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 12
        button.addTarget(self,
                         action: #selector(tuppedSignInButton),
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

private extension SignInViewController {
    func setupView() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        
        view.addSubview(registrationButton)
        view.addSubview(imageView)
        view.addSubview(emailTF)
        view.addSubview(passwordTF)
        view.addSubview(signUpButton)
        
        setupLayout()
    }
}

    // MARK: - @Objc private Methods

private extension SignInViewController {
    @objc func tuppedRegistrationButton() {
        let vc = SignUpViewController()
        vc.modalPresentationStyle = .fullScreen
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tuppedSignInButton() {
        if checkDataTF() {
            guard let email = emailTF.text else { return }
            guard let password = emailTF.text else { return }
            
            
            networkManager.auth.signIn(withEmail: email,
                                       password: password) { (authResult, error) in
                
                guard error == nil else {
                    print("Error SignIn")
                    print(error?.localizedDescription ?? "Error SignIn")
                    return
                }
                
                
                guard let result = authResult else { return }
                print(result.user.email ?? "email - not found")
                print(result.user.uid)
                print("user SignIn")
                
                self.showMainVC()
            }
        } else {
            showAlert("Error")
        }
    }
}

    // MARK: - Private Methods

private extension SignInViewController {
    
    func showMainVC() {
        let vc = MainViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true)
    }
    
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
}

    // MARK: - Layout

private extension SignInViewController {
    func setupLayout() {
        registrationButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            registrationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            registrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            registrationButton.widthAnchor.constraint(equalToConstant: 120)
        ])
        
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


