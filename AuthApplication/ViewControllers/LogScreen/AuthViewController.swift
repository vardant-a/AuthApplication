//
//  AuthViewController.swift
//  AuthApplication
//
//  Created by Aleksei on 17.01.2023.
//

import UIKit

final class AuthViewController: UIViewController {
    
    // MARK: - Network Manager
    
    private let networkManager = NetworkManager.shared
    
    // MARK: - Private lazy Properties
    
    private var statusAuth = false
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "LogoSVG")
        
        return imageView
    }()
    
    private lazy var greetingLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 32)
        
        return label
    }()
    
    private lazy var phoneTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Please enter phone number"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .gray
        textField.keyboardType = .numberPad
        
        return textField
    }()
    
    private lazy var smsCodeTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "SMS Code"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .gray
        textField.keyboardType = .numberPad
        
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

private extension AuthViewController {
    func setupView() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        view.addSubview(imageView)
        view.addSubview(greetingLabel)
        view.addSubview(phoneTF)
        view.addSubview(smsCodeTF)
        view.addSubview(getSMSCodeButton)
        view.addSubview(verifyButton)
        
        setupLayout()
    }
}

    // MARK: - @Objc private Methods

private extension AuthViewController {
    @objc func tuppedGetSMSCodeButton() {
        phoneTF.resignFirstResponder()
        
        if let content = phoneTF.text, !content.isEmpty {
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
        
        phoneTF.isEnabled.toggle()
        smsCodeTF.isEnabled.toggle()
    }
    
    @objc func tuppedVerifyButton() {
        smsCodeTF.resignFirstResponder()
        
        if let smsCode = smsCodeTF.text, !smsCode.isEmpty {
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

    // MARK: - Transition private Method

extension AuthViewController {
    func showMainVC() {
        let vc = MainViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true)
    }
}

    // MARK: - Layout

private extension AuthViewController {
    func setupLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        smsCodeTF.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            smsCodeTF.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            smsCodeTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            smsCodeTF.heightAnchor.constraint(equalToConstant: 44),
            smsCodeTF.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        phoneTF.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            phoneTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneTF.bottomAnchor.constraint(equalTo: smsCodeTF.topAnchor, constant: -20),
            phoneTF.heightAnchor.constraint(equalToConstant: 44),
            phoneTF.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        greetingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            greetingLabel.leadingAnchor.constraint(equalTo: phoneTF.leadingAnchor),
            greetingLabel.bottomAnchor.constraint(equalTo: phoneTF.topAnchor, constant: -12)
        ])
        
        getSMSCodeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            getSMSCodeButton.topAnchor.constraint(equalTo: smsCodeTF.bottomAnchor, constant: 20),
            getSMSCodeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getSMSCodeButton.heightAnchor.constraint(equalToConstant: 44),
            getSMSCodeButton.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        verifyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verifyButton.topAnchor.constraint(equalTo: smsCodeTF.bottomAnchor, constant: 20),
            verifyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verifyButton.heightAnchor.constraint(equalToConstant: 44),
            verifyButton.widthAnchor.constraint(equalToConstant: 300)
        ])
        
    }
}
