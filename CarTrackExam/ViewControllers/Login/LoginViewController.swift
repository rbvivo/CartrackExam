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

    let viewModel: LoginViewModel = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
    }
    
    @IBAction private func loginPressed(){
        viewModel.login(name: nameField.text ?? "", password: passwordField.text ?? "")
        viewModel.verifySuccess = { [weak self] in
            
        }
        viewModel.verifyFailed = { [weak self] in
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
