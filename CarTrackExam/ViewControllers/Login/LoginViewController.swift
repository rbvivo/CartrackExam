//
//  LoginViewController.swift
//  CarTrackExam
//
//  Created by Bryan Vivo on 9/14/20.
//  Copyright © 2020 Bryan Vivo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var countryField: UITextField!
    private let viewModel: LoginViewModel = LoginViewModel()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .black
        return activityIndicator
    }()

   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupIndicator()
    }
    
    private func setupIndicator() {
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @IBAction private func loginPressed(){
        activityIndicator.startAnimating()
        self.view.endEditing(true)
        viewModel.login(name: nameField.text ?? "", password: passwordField.text ?? "")
        viewModel.verifySuccess = { [weak self] in
            self?.activityIndicator.stopAnimating()
            let userController = UserListViewController()
            self?.navigationController?.pushViewController(userController, animated: true)
        }
        viewModel.verifyFailed = { [weak self] in
            self?.activityIndicator.stopAnimating()
            let alertView = UIAlertController(title: "Error", message: "Wrong Username or Password", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertView.addAction(okAction)
            self?.present(alertView, animated: true, completion: nil)
        }
    }
    
    @IBAction private func countryFieldPressed() {
        let countryController = CountryListViewController()
        let navigation = UINavigationController(rootViewController: countryController)
        self.present(navigation, animated: true, completion: nil)
        countryController.selectCountry = { [weak self] selectedCountry in
            self?.countryField.text = selectedCountry
        }
    }
}
