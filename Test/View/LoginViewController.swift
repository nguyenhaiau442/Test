//
//  LoginViewController.swift
//  Test
//
//  Created by Nguyễn Hải Âu on 10/21/20.
//  Copyright © 2020 Nguyễn Hải Âu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "LOGIN"
        l.font = UIFont.boldSystemFont(ofSize: 32)
        l.textAlignment = .center
        return l
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.placeholder = "Email"
        tf.font = UIFont.systemFont(ofSize: 15)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.placeholder = "Password"
        tf.font = UIFont.systemFont(ofSize: 15)
        tf.isSecureTextEntry = true
        return tf
    }()
    
    lazy var loginButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = .brown
        b.setTitle("LOGIN", for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        b.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        return b
    }()
    
    let loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    @objc private func loginButtonClicked() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        loginViewModel.login(email: email, password: password) { (result) in
            switch result {
            case .success(let msg):
                print(msg)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.changeScreen(screenType: .tabbar)
            case .failure(let isError, let errorMsg):
                if isError {
                    print("Đăng nhập thất bại")
                    print(errorMsg)
                }
            }
        }
    }
    
    private func setupUI() {
        view.addSubview(loginLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        let constraints = [
            loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            emailTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 40),
            emailTextField.leadingAnchor.constraint(equalTo: loginLabel.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: loginLabel.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 45),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 12),
            passwordTextField.leadingAnchor.constraint(equalTo: loginLabel.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: loginLabel.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 45),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 100),
            loginButton.leadingAnchor.constraint(equalTo: loginLabel.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: loginLabel.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 45)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
