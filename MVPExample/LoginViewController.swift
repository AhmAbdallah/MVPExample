//
//  ViewController.swift
//  MVPExample
//
//  Created by Ahmed Abdallah on 24.01.2019.
//  Copyright © 2019 4A5. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, PresenterInterfaceDelegate {
    //your UI elements
    @IBOutlet weak var userNameTXTField: UITextField!
    @IBOutlet weak var passwordTXTField: UITextField!
    @IBOutlet weak var messageLBL: UILabel!
    
    private var presenter = LoginPresenter()
    private var activityIndicator: UIActivityIndicatorView?
    //MARK: you interface implementation
    func showErrorMessage(message: String) {
        messageLBL.textColor = .red
        messageLBL.text = message
    }
    
    func showSuccesMessage() {
        // You will see here that no connection between the model and the view
        messageLBL.textColor = .green
        messageLBL.text = "Hi \(presenter.firstName!) \(presenter.lastName!)"
    }
    
    @IBAction func loginActionBTN(_ sender: Any) {
        
        self.presenter.checkLoginData(userName: self.userNameTXTField.text!, password: self.passwordTXTField.text!)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        presenter.delegate = self
        activityIndicator = presenter.activityIndicator
        //this part need to have more best practice
        activityIndicator!.center = view.center
        activityIndicator!.color = UIColor.yellow
        view.addSubview(activityIndicator!)
    }


}

