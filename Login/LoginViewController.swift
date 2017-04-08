//
//  LoginViewController.swift
//  Login
//
//  Created by Paige Plander on 4/5/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Constants used in the LoginViewController
    struct Constants {
        static let backgroundColor: UIColor = UIColor(hue: 0.5389, saturation: 1, brightness: 0.92, alpha: 1.0)
        static let invalidEmailTitle = "Invalid username or password"
        static let invalidEmailMessage = "Please try again"
    }

    // TODO: instantiate the views needed for your project
    
    let smallView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 20
        return view
    }()
    let loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.backgroundColor = UIColor.white
        return textField
    }()
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.backgroundColor = UIColor.white
        return textField
    }()
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir", size: 30)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = Constants.backgroundColor
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(login), for: .touchDown)
        return button
        
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.text = "Welcome"
        label.font = UIFont(name: "Avenir", size: 32)
        label.textColor = UIColor.white
        return label
    }()
    let frameWidth = UIScreen.main.bounds.width
    let frameHeight = UIScreen.main.bounds.height
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        // TODO: Add your views either as subviews of `view` or subviews of each other using `addSubview`
        view.addSubview(smallView)
        smallView.addSubview(loginTextField)
        smallView.addSubview(passwordTextField)
        smallView.addSubview(loginButton)
        view.addSubview(titleLabel)
        // TODO: layout your views using frames or AutoLayout
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        smallView.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            smallView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            smallView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            smallView.heightAnchor.constraint(equalToConstant: frameHeight/3),
            smallView.widthAnchor.constraint(equalToConstant: frameWidth - 20),
//            btn.leadingAnchor.constraint(equalTo: view.leadingAnchor,
//                                         constant: 8),
//            btn.trailingAnchor.constraint(equalTo: view.trailingAnchor,
//                                          constant: 8),
            loginButton.bottomAnchor.constraint(equalTo: smallView.bottomAnchor , constant: -10),
            loginButton.heightAnchor.constraint(equalToConstant: frameHeight/12),
            loginButton.widthAnchor.constraint(equalToConstant: frameWidth/3),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//
            passwordTextField.bottomAnchor.constraint(equalTo: loginButton.topAnchor , constant: -10),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.leadingAnchor.constraint(equalTo: smallView.leadingAnchor, constant: 10),
//            passwordTextField.widthAnchor.constraint(equalToConstant: frameWidth/2),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -10),
            loginTextField.heightAnchor.constraint(equalToConstant: 40),
            loginTextField.leadingAnchor.constraint(equalTo: smallView.leadingAnchor, constant: 10),
            // loginTextField.widthAnchor.constraint(equalToConstant: frameWidth/2),
            loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: smallView.topAnchor, constant: -30),
            titleLabel.leadingAnchor.constraint(equalTo: smallView.leadingAnchor, constant: 0),
            titleLabel.heightAnchor.constraint(equalToConstant: frameHeight/7)
            
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    // TODO: create an IBAction for your login button
    @IBAction func login(sender: UIButton) {
        let password = passwordTextField.text
        let username = loginTextField.text
        authenticateUser(username: username, password: password)
    }
    
    
    
    
    /// YOU DO NOT NEED TO MODIFY ANY OF THE CODE BELOW (but you will want to use `authenticateUser` at some point)
    
    // Model class to handle checking if username/password combinations are valid.
    // Usernames and passwords can be found in the Lab6Names.csv file
    let loginModel = LoginModel(filename: "Lab6Names")

    /// Imageview for login success image (do not need to modify)
    let loginSuccessView = UIImageView(image: UIImage(named: "oski"))
    
    /// If the provided username/password combination is valid, displays an
    /// image (in the "loginSuccessView" imageview). If invalid, displays an alert
    /// telling the user that the login was unsucessful.
    /// You do not need to edit this function, but you will want to use it for the lab.
    ///
    /// - Parameters:
    ///   - username: the user's berkeley.edu address
    ///   - password: the user's first name (what a great password!)
    func authenticateUser(username: String?, password: String?) {
        
        // if username / password combination is invalid, present an alert
        if !loginModel.authenticate(username: username, password: password) {
            loginSuccessView.isHidden = true
            let alert = UIAlertController(title: Constants.invalidEmailTitle, message: Constants.invalidEmailMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        // If username / password combination is valid, display success image
        else {
            if !loginSuccessView.isDescendant(of: view) {
                view.addSubview(loginSuccessView)
                loginSuccessView.contentMode = .scaleAspectFill
            }
            
            loginSuccessView.isHidden = false
            
            // Constraints for the login success view
            loginSuccessView.translatesAutoresizingMaskIntoConstraints = false
            loginSuccessView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            loginSuccessView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            loginSuccessView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            loginSuccessView.heightAnchor.constraint(equalToConstant: view.frame.height/4).isActive = true
        }
    }
}
