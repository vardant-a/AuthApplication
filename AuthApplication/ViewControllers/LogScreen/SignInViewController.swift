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
    
    private var statusAuth = false
    
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
        
        textField.isEnabled = false
        
        return textField
    }()
    
    private lazy var getSMSCodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get SMS Code ->", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 12
        button.addTarget(self,
                         action: #selector(tuppedGetSMSCodeButton),
                         for: .touchUpInside)
        
        return button
    }()
    
    private lazy var verifyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Verifycation", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 12

        button.isEnabled = false
        button.isHidden = true
        
        button.addTarget(self,
                         action: #selector(tuppedVerifyButton),
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
        view.addSubview(imageView)
        view.addSubview(emailTF)
        view.addSubview(passwordTF)
        view.addSubview(getSMSCodeButton)
        view.addSubview(verifyButton)
        
        setupLayout()
    }
}

    // MARK: - @Objc private Methods

private extension SignInViewController {
    @objc func tuppedGetSMSCodeButton() {
        emailTF.resignFirstResponder()
        
        if let content = emailTF.text, !content.isEmpty {
            let number = "+7\(content)"
            networkManager.startAuth(phoneNumber: number) { [weak self] success in
                guard success else {
                    self?.showAlert("Phone number not found")
                    return
                }
                
                DispatchQueue.main.async {
                    self?.switchStatusView()
                }
            }
        }
    }
    
    
    func switchStatusView() {
        getSMSCodeButton.isEnabled.toggle()
        getSMSCodeButton.isHidden.toggle()
        
        verifyButton.isEnabled.toggle()
        verifyButton.isHidden.toggle()
        
        emailTF.isEnabled.toggle()
        passwordTF.isEnabled.toggle()
    }
    
    @objc func tuppedVerifyButton() {
        passwordTF.resignFirstResponder()
        
        if let smsCode = passwordTF.text, !smsCode.isEmpty {
            
            networkManager.verityCode(smsCode: smsCode) { [weak self] success in
                
                guard success else {
                    self?.showAlert("Error smsCode")
                    return
                }
                
                DispatchQueue.main.async {
                    self?.showMainVC()
                }

            }
        }
    }
}

    // MARK: - Private Methods

extension SignInViewController {
    func showMainVC() {
        let vc = MainViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true)
    }
}

    // MARK: - Layout

private extension SignInViewController {
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
        
        getSMSCodeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            getSMSCodeButton.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 20),
            getSMSCodeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getSMSCodeButton.heightAnchor.constraint(equalToConstant: 44),
            getSMSCodeButton.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        verifyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verifyButton.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 20),
            verifyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verifyButton.heightAnchor.constraint(equalToConstant: 44),
            verifyButton.widthAnchor.constraint(equalToConstant: 200)
        ])
        
    }
}
