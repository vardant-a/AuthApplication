//
//  MainViewController.swift
//  AuthApplication
//
//  Created by Aleksei on 17.01.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let networkManager = NetworkManager.shared
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "main")
        
        return imageView
    }()
    
    private lazy var nameTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .gray
        textField.isHidden = true
        
        return textField
    }()
    
    private lazy var adressTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Adrees"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .gray
        textField.isHidden = true
        
        return textField
    }()
    
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
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(nameTF)
        view.addSubview(adressTF)
        view.addSubview(logOutButton)
        
        setupLayout()
    }
}

    // MARK: - @Objc private Methods

private extension MainViewController {
    @objc func tuppedLogOutButton() {
        networkManager.logOut()
    }
}

    // MARK: - Layout

private extension MainViewController {
    func setupLayout() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 350),
            imageView.widthAnchor.constraint(equalToConstant: 350)
        ])
        
        nameTF.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTF.widthAnchor.constraint(equalToConstant: 200),
            nameTF.bottomAnchor.constraint(equalTo: adressTF.topAnchor, constant: -40)
        ])
        
        adressTF.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            adressTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            adressTF.widthAnchor.constraint(equalToConstant: 200),
            adressTF.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
        ])
        
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logOutButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            logOutButton.heightAnchor.constraint(equalToConstant: 44),
            logOutButton.widthAnchor.constraint(equalToConstant: 300),
        ])
    }
}
