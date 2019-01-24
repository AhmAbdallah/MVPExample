//
//  LoginPresenter.swift
//  MVPExample
//
//  Created by Ahmed Abdallah on 24.01.2019.
//  Copyright © 2019 4A5. All rights reserved.
//

import Foundation
import UIKit

//you will need an interface between your Presenter and the view (view or viewController) you can use the protocol

protocol PresenterInterfaceDelegate: NSObjectProtocol {
    func showErrorMessage(message: String)
    func showSuccesMessage()
}

// Start creating you owen Presenter
class LoginPresenter: NSObject {
    
    var delegate: PresenterInterfaceDelegate?
    // be sure there is no connection between your model and Viewcontroller set it to private :)
    private var userData:  UserModel?
    //here an example of how to send data from the presenter to viewController
    var firstName: String?
    var lastName: String?
    //you can define some UI elements
    var activityIndicator = UIActivityIndicatorView(style: .white)
    
    //set you validition here
    func checkLoginData(userName: String, password: String){
        if userName.isEmpty{
            delegate?.showErrorMessage(message: "UserName is empty!")
        }else{
            if password.isEmpty{
                delegate?.showErrorMessage(message: "Password is empty!")
            }else{
                    self.storeUserData(userName: userName, password: password)
            }
        }
    }
    //You can call the service logic here I mean your webservice
    private func storeUserData(userName: String, password: String){
        //this delay to act like calling something from the server but take care its not a best practice
        self.showProgress()
        let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
                self.hideProgress()
                //here you can deal with your data that came from the server
                if userName == "mvp" && password == "123"{
                    self.userData = UserModel(email: "ahmabdallah5@gmail.com", firstName: "Ahmed", lastName: "Abdallah")
                    self.firstName = self.userData?.firstName
                    self.lastName = self.userData?.lastName
                    self.delegate?.showSuccesMessage()
                }else{
                    self.delegate?.showErrorMessage(message: "Invalid Data!")
                    }
        }
        
    }
    //some functions for dealing with the progress 
    func showProgress() {
        activityIndicator.startAnimating()
    }
    
    func hideProgress() {
        activityIndicator.stopAnimating()
    }
}
